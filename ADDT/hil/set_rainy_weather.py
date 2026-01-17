#!/usr/bin/env python3

import carla
import random


# Connect to the CARLA server
client = carla.Client('localhost', 2000)
client.set_timeout(10.0)  # seconds
print(client.get_available_maps())
# Get the world object
world = client.get_world()
#world = client.load_world('66')
#settings = world.get_settings()
#settings.synchronous_mode = True
#world.apply_settings(settings)


# Retrieve the vehicle by ID
# vehicle_id = 'ego_vehicle'  # The ID of your vehicle
#vehicle = None
#for actor in world.get_actors():
#    print("Vehicle not found")
#    if actor.attributes.get('role_name') == vehicle_id:
#        vehicle = actor
#        break

#if vehicle is None:
#    print("Vehicle not found")
#else:
    # Apply control to the vehicle
    #control = carla.VehicleControl()
    #control.throttle = 1.0  # Accelerate
    #control.steer = 0.0     # Go straight
    #vehicle.apply_control(control)

    #print(f"Velocity applied to vehicle {vehicle_id}")


#settings.fixed_delta_seconds = 0.01
#world.apply_settings(settings)

#print(settings)

#blueprint_library = world.get_blueprint_library()

# Find a specific blueprint.
#collision_sensor_bp = blueprint_library.find('sensor.other.collision')
# Choose a vehicle blueprint at random.
#vehicle_bp = blueprint_library.filter('vehicle.audi.a2')
#blueprint_library = world.get_blueprint_library()
#camera_bp = blueprint_library.find('sensor.camera.rgb')  # For an RGB camera

#camera_bp.set_attribute('sensor_tick', '0.033')  # For 30 FPS
#blueprint_library = world.get_blueprint_library()
#camera_bp = blueprint_library.find('sensor.camera.rgb')  # For an RGB camera
#sensor_tick = camera_bp.get_attribute('sensor_tick')
#print(f"The sensor_tick of sensor.camera.rgb is: {sensor_tick}")

# Load layered map for Town 01 with minimum layout plus buildings and parked vehicles
#world = client.load_world('Town01_Opt', carla.MapLayer.Buildings | carla.MapLayer.ParkedVehicles)

# Toggle all buildings off
world.unload_map_layer(carla.MapLayer.Buildings)
world.unload_map_layer(carla.MapLayer.Decals)

#map_layer(carla.MapLayer.Foliage)
#world.unload_map_layer(carla.MapLayer.StreetLights)
#world.unload_map_layer(carla.MapLayer.Walls)
#world.unload_map_layer(carla.MapLayer.ParkedVehicles)
#world.unload_map_layer(carla.MapLayer.Particles)
#world.unload_map_layer(carla.MapLayer.Props)


# Toggle all buildings on   
# world.load_map_layer(carla.MapLayer.Buildings)

# Define rainy weather
rainy_weather = carla.WeatherParameters(
    cloudiness=85.0,  # Completely overcast
    precipitation=0.0,  # Maximum rain
    wetness=0.0,  # Wet ground
    precipitation_deposits=0.0,  # Raindrops on surfaces
    wind_intensity=0.0,  # Some wind for effect, adjust as desired
    sun_altitude_angle=50.0
)



# Set the weather
world.set_weather(rainy_weather)


