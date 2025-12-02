from openmm import app, LangevinMiddleIntegrator, Platform
from openmm.app import DCDReporter, StateDataReporter, Simulation, DCDFile
from openmm.app import forcefield as ff
from openmm.unit import picoseconds, nanometers, bar, kelvin, degree, angstrom,kilocalories_per_mole


def get_energy_force(jobname, boxsize):

    latta = boxsize * angstrom
    lattb = boxsize * angstrom
    lattc = boxsize * angstrom

    # Read PSF File
    psf = app.CharmmPsfFile('dhfr.psf')
    psf.setBox(latta, lattb, lattc, 90.*degree, 90.*degree, 90.*degree)
    crd = app.CharmmCrdFile(jobname+'.crd')

    # Load the parameter set.
    params = app.CharmmParameterSet('par_all22_prot.inp', 'top_all22_prot.inp') 

    system = psf.createSystem(
        params=params, 
        nonbondedCutoff=1.2*nanometers, 
        nonbondedMethod=ff.PME,
        ewaldErrorTolerance=0.00001,
        constraints=ff.HBonds
    )

    temp=298.15

    integrator = LangevinMiddleIntegrator(
        300*kelvin, 
        1/picoseconds, 
        0.002*picoseconds
    )

    platform = Platform.getPlatformByName('CUDA')
    prop = {'Precision': 'mixed'}
    simulation = Simulation(
        psf.topology, 
        system, 
        integrator,
        platform,
        prop
    )

    simulation.context.setPositions(crd.positions)
    state = simulation.context.getState(
        getEnergy=True,
        getForces=True,
    )

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
            output_file.write(str(state.getPotentialEnergy().value_in_unit(kilocalories_per_mole)))
            output_file.write('\n')




if __name__ == '__main__':
    for i in range(1,11,2):
        get_energy_force('dhfr'+str(i), 75.)
    
