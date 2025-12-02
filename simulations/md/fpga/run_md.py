from openmm.app import *
from openmm import *
from openmm.unit import picoseconds, nanometers, bar, kelvin


nptstep = 50_000
dumpint = int(nptstep/50000)

###########################

print('Loading PDB...')
pdb = PDBFile('dhfr.pdb')
forcefield = ForceField('amber99sb.xml', 'tip3p.xml')
modeller = Modeller(pdb.topology, pdb.positions)


platform = Platform.getPlatformByName('CUDA')
prop = {'Precision': 'Mixed'}


print('Minimizing...')
system = forcefield.createSystem(
    modeller.topology, 
    nonbondedCutoff=0.9*nanometers, 
    nonbondedMethod=PME,
    ewaldErrorTolerance=0.00001,constraints=HBonds
)

temp=298.15

integrator = LangevinMiddleIntegrator(
    300*kelvin, 1/picoseconds, 0.002*picoseconds
)


baro = system.addForce(
    MonteCarloBarostat(1*bar,temp*kelvin)
)

simulation = Simulation(
    modeller.topology, system, integrator,platform,prop
)

simulation.context.setPositions(modeller.positions)
simulation.minimizeEnergy(maxIterations=100)
print('Saving...')

# MD
simulation.context.setVelocitiesToTemperature(temp*kelvin)
dcd=DCDReporter('dhfr.dcd', dumpint)
firstdcdstep = 0
dcd._dcd = DCDFile(dcd._out,
    simulation.topology,
    simulation.integrator.getStepSize(),
    firstdcdstep, 
    dumpint
)


simulation.reporters.append(dcd)

simulation.reporters.append(
    StateDataReporter(
        'ther', 
        dumpint,
        step=True, 
        totalEnergy=True,
        potentialEnergy=True, 
        kineticEnergy=True,
        temperature=True,
        separator=','
    )
)

simulation.step(nptstep)
simulation.reporters.pop()


dcd._out.close()

print('Done')
