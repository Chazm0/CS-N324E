<project4> Report for <zc5983>
====================================

## Instructions

<Open zc5983_project4 in Processing and click Run. Press 'Q' to switch between camera modes (orbital and FPS). Left-click and drag to rotate the view for both camera modes. Right-click and drag vertically in orbital mode to zoom in/out the camera, and use the number keys 0-8 to switch the camera focus between the Sun and the 8 planets in orbital mode; use W, A, S, D to move the camera in FPS mode.>

## Report

<Narrative: Our solar system. The Sun is at the center and eight planets orbit around it.

Classes:
    CelestialBody: Creates basic celestial bodies (Sun, planets, Moon).
    Planet: Represents a planet orbiting a parent body.
    Moon: Represents Moon orbiting Earth.
    Camera: Base class for camera functionality.
    OrbitalCamera: Implements an orbital camera with rotation, zooming, and resetting center.
    FPSCamera: Implements a first-person camera with movement and rotation.

Transformations
    CelestialBody: Translate (orbit).
    Camera: Translate and rotate.

Instances
    Planets: Different sizes, colors, orbit radii, and speeds.
    Camera: Two completely distinct camera modes.

Challenges
    Ensuring the FPS camera did not suffer from floating-point errors causing precession. Custom rotation methods were implemented to pin the camera’s up direction.

Assistance
Used ChatGPT for debugging and teaching certain implementations.>