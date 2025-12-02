from openmm.app import *
from openmm import *
from openmm.unit import picoseconds, nanometers, bar, kelvin


def get_energy_force(jobname):
    pdb = PDBFile(jobname + '.pdb')
    forcefield = ForceField('amber99sb.xml', 'tip3p.xml')
    modeller = Modeller(pdb.topology, pdb.positions)

    platform = Platform.getPlatformByName('CUDA')

    system = forcefield.createSystem(
        modeller.topology, 
        nonbondedCutoff=0.9*nanometers, 
        nonbondedMethod=PME,
        ewaldErrorTolerance=0.00001,constraints=HBonds
    )

    f:Force
    for i, f in enumerate(system.getForces()):
        #print(f.getName())
        f.setForceGroup(i+1)
        #print(f.getForceGroup())

    temp=298.15

    integrator = LangevinMiddleIntegrator(
        300*kelvin, 1/picoseconds, 0.002*picoseconds
    )


    prop = {'Precision': 'mixed'}
    simulation = Simulation(
        modeller.topology, system, integrator, platform, prop
    )

    simulation.context.setPositions(modeller.positions)

    with open(jobname+'_energy_force.log', 'w') as output_file:
        state = simulation.context.getState(
                getEnergy=True, 
        )
        output_file.write('Total: ' + str(state.getPotentialEnergy()) + '\n')
        for f in system.getForces():
            state = simulation.context.getState(
                getEnergy=True, 
                groups=2**f.getForceGroup()
            )
            output_file.write(str(f.getForceGroup()))
            output_file.write(', ')
            output_file.write(str(f.getName()))
            output_file.write(', ')
            output_file.write(str(state.getPotentialEnergy()))
            output_file.write('\n')

if __name__ == '__main__':
    for i in range(5):
        get_energy_force('dhfr'+str(i+1))
