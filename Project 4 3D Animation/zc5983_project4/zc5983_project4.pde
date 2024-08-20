CelestialBody sun;
Planet[] planets;
Moon[] moons;

OrbitalCamera orbitalCam;
FPSCamera fpsCam;
boolean useOrbital = true;

void setup() {
  size(800, 800, P3D);
  noStroke();

  emissive(color(255, 220, 0));
  sun = new CelestialBody(0, 0, 0, 150, color(255, 220, 0));
  //Planets parameters provided by ChatGPT
  emissive(0);
  
  planets = new Planet[8];
  planets[0] = new Planet(10, color(255, 204, 0), 200, 0.02, sun); // Mercury
  planets[1] = new Planet(20, color(255, 153, 51), 250, 0.015, sun); // Venus
  planets[2] = new Planet(22, color(0, 102, 204), 300, 0.01, sun); // Earth
  planets[3] = new Planet(15, color(204, 0, 0), 350, 0.007, sun); // Mars
  planets[4] = new Planet(45, color(255, 153, 0), 500, 0.005, sun); // Jupiter
  planets[5] = new Planet(38, color(255, 204, 153), 600, 0.004, sun); // Saturn
  planets[6] = new Planet(32, color(0, 153, 255), 700, 0.003, sun); // Uranus
  planets[7] = new Planet(30, color(0, 0, 153), 800, 0.002, sun); // Neptune

  moons = new Moon[1];
  moons[0] = new Moon(5, color(150, 150, 150), 30, 0.05, planets[2]);

  orbitalCam = new OrbitalCamera(new PVector(0, 0, 0), 600); 
  fpsCam = new FPSCamera(new PVector(0, 0, 600), new PVector(0, 0, 0));
  

}

void draw() {
  background(0);
  
  if (useOrbital) {
    orbitalCam.apply();
  } else {
    fpsCam.apply();
  }

  sun.display();
  noLights();
  pointLight(255, 220, 0, sun.position.x, sun.position.y, sun.position.z);
  
  for (Planet planet : planets) {
    planet.display();
  }

  for (Moon moon : moons) {
    moon.display();
  }
}

void keyPressed() {
  if (key == 'q' || key == 'Q') {
    useOrbital = !useOrbital;
  } else if (key == '0') {
    orbitalCam.setTarget(new PVector(0, 0, 0)); // Sun
  } else if (key == '1') {
    orbitalCam.setTarget(planets[0].position); // Mercury
  } else if (key == '2') {
    orbitalCam.setTarget(planets[1].position); // Venus
  } else if (key == '3') {
    orbitalCam.setTarget(planets[2].position); // Earth
  } else if (key == '4') {
    orbitalCam.setTarget(planets[3].position); // Mars
  } else if (key == '5') {
    orbitalCam.setTarget(planets[4].position); // Jupiter
  } else if (key == '6') {
    orbitalCam.setTarget(planets[5].position); // Saturn
  } else if (key == '7') {
    orbitalCam.setTarget(planets[6].position); // Uranus
  } else if (key == '8') {
    orbitalCam.setTarget(planets[7].position); // Neptune
  }
}
