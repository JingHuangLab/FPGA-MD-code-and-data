from openmm import app, LangevinMiddleIntegrator, Platform
from openmm.app import DCDReporter, StateDataReporter, Simulation, DCDFile
from openmm.app import forcefield as ff
from openmm.unit import picoseconds, nanometers, bar, kelvin, degree, angstrom


def get_energy_force(jobname, boxsize):

    latta = boxsize * angstrom
    lattb = boxsize * angstrom
    lattc = boxsize * angstrom

    # Read PSF File
    psf = app.CharmmPsfFile('argon.psf')
    psf.setBox(latta, lattb, lattc, 90.*degree, 90.*degree, 90.*degree)
    crd = app.CharmmCrdFile(jobname+'.crd')

    # Load the parameter set.
    params = app.CharmmParameterSet('argon.str') 

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

    return str(state.getPotentialEnergy())


if __name__ == '__main__':
    with open('energy.dat','w') as f:
        for i in range(5):
            f.write(get_energy_force('argon'+str(i+1), 30.)+ '\n')
