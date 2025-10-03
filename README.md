# Group_2-Comp_360-Assignment_1
Assignment 1 for COMP 360 from Group 2

<br>

# GROUP 2 - COMP 360 - ON1 - GROUP EXPLANATION
# Project Init: (Jason Haug)

## Initialization
For this project, we created a 3D terrain map in Godot using procedural generation techniques. <br>
We used FastNoiseLite to generate a grayscale noise texture, which served as the heightmap for our terrain. <br>
Each pixel's brightness in the noise image was mapped to a corresponding vertex height in 3D space, forming valleys and peaks. <br>
We constructed the terrain mesh using the SurfaceTool, connecting neighboring pixels into triangles. <br>
To enhance realism, we added color mapping based on elevation, simulating rivers, grasslands, mountains, and snowy peaks. <br><br>

## Node Utilization:
The scene utilizes several 3D nodes:
- MeshInstance3D for rendering the terrain mesh

- Marker3D for camera positioning and movement

- Camera3D for interactive navigation and zoom

- DirectionalLight3D and WorldEnvironment for lighting, shadows, and atmospheric effects

<br>

This approach allowed us to build a visually rich and interactive terrain environment, demonstrating procedural geometry, color mapping, and advanced scene setup in Godot.<br>

---------------------------------------------------------
# Project 2D Image Addition Explanation: (Akshit Marwaha)

## Implementation

Loaded a grayscale 2D image and sampled pixel intensities
Mapped image coordinates to 3D where x and z come from pixel position and y comes from normalized brightness
Built a heightmap mesh by connecting neighboring pixels into triangles

## The Why

Brighter pixels form peaks and darker pixels form valleys, creating a clear terrain base for the team’s color and lighting work

## Key Notes

Reduced sampling resolution to improve performance while keeping terrain features clear
Integrated cleanly with the existing geometry and environment settings

---------------------------------------------------------
# Project Geometry Map Explanation: (Christian)
<br>
I first took a look at how the Geometry3D example project worked. I noticed that the project used surface tool, so I figured that I should start there.
The Godot documentation on the surface tool helped me understand how it works:
https://docs.godotengine.org/en/4.4/tutorials/3d/procedural_geometry/surfacetool.html

## First Idea
I first set up a single triangle by placing 3 vertices and adding the 3 indices. From there I tried to make a square. I did this by creating 3 more vertices adding those new indices.
Next up I tried to sample the image. The image is black and white. The goal is for the brighter colours to have a greater height, which would simulate an environment.

To sample the image I looped through the 500x500 FastNoiseLite noise image. For each pixel I would create 6 vertices and index them.
This time i was setting the vertices position to Vector3(x, value of noise at xz, z), which creates the landscape.

After doing this I re-read the documentation and realised that I don't need 6 vertices per pixel, I only need 1 per pixel. Then I should reuse the vertices for the neighbouring pixels.

## Improvement
So I re-did the geometry, this time I first set up the vertices by looping through the image and creating one vertex per pixel.
Then I looped through the pixels again, this time indexing 6 vertices in the shape of a square.
I could have done some simple math to calculate which indices I would need to construct the square, but I instead made a 2d array in which I would temporarily store each index.

End result was this black and white terrain!
![result](https://github.com/user-attachments/assets/d9312754-1b6d-43e8-a7cf-c88a1fad9679)

---------------------------------------------------------
# Project Camera3D Explanation: (Zoe Antonio)

## Importance
Camera 3D displays a point of view and it determines what you see, how close or far things look, and from what angle you’re looking at the 3D landscape. Without it we would have a blank screen as Godot would not know which part of 3D scene would need to be shown.

## Implementation
- We used lerp/linear interpolation to make smooth transitions as you zoom in and out
- Included event.button_index script to allow the scroll button to zoom in and out
- In tandem with Marker3D you can rotate around a marker with the middle button, use WASD for a keyboard-style panning, and designed the scene to constantly rotate when idle 

## Why
We created these implementations to allow for our generated terrain to be explorable similar to map editor not just a static picture.

## Summary
Overall our script allows for:
- Free exploration with mouse and keyboard
- Smooth zoom in and out of the landscape
- Orbiting around a marker to view different angles

<br>
## Reference
Godot Documentation
https://docs.godotengine.org/en/stable/classes/class_camera3d.html

---------------------------------------------------------
# Project Environment Explanation: (Bhavik Wadhwa)

## Creation
The environment of the project was initialized upon adding a standard colorwave onto the geometry we 
had already established. Once realizing the possibility of the world building we could do from it, we added
in the proper use of shadows, lighting, and more to bring it more life for when we add in the colors of the world.

## Usage
The main improvement came from adding a sun-like DirectionalLight3D. This gave the terrain depth by showing shadows and highlights across the hills.
We tweaked the energy settings so the light made the surface roughness stand out without washing out the colors. 
Without light, the terrain looked smooth and lifeless, but with it, the shapes became much clearer.

## Further Usage
By adding in volumetric fog and a better black border, it helped to separate the difference between each segment of the 
environment. We added in a directional shadow as well with blend splits to help distinguish the finer spots on the map, 
which assisted in blending in the various color hues we had made with one another. 

## In Conjuction with Camera3D
We set the light source so it feels like the sun is above both the terrain and the viewer. 
This gives a “from above” perspective, which worked well with the free camera controls, since you can fly around and see the terrain under different angles.  

## Environment References
- An example of the reference map with no light or shadows being added
https://github.com/j7ysan/GodotTerrainMap/blob/main/no_light_reference1.png

<br>

- An example or examples of the reference map with light and shadows being added
https://github.com/j7ysan/GodotTerrainMap/blob/main/with_light_reference2.png

---------------------------------------------------------
# Project Marker3D Explanation: (Manmeet)

## Why

- In our project, we used only one Marker3D node, but for some examples, I will mention more than one. 

- Rather than making an array of Camera3D nodes, we utilized Marker3D nodes as markers in the world.

- This enabled us to establish important positions and camera orientations without paying for increased performance costs.

## How

- Marker3D nodes were set at significant spots in the game scene (e.g., map overview, terrain highs, player spawn).

- The root Camera3D may then move or snap to Marker3D nodes programmatically.

- It simplifies controlling points of view when it's time for extrusions or cutscene switching.

## Effect

- Better efficiency: A single active Camera3D suffices, cutting down on processor overhead.

- Flexibility: Alternative perceptions may be generated shifting the camera to auxiliary markers.

- Clean design: Keeps the project symptom-free and modular as markers serve as virtual anchors not additional cameras.

## Example Use Case

- Marker3D at the top of the mountain enables the camera to change its viewpoint to the summit. Another Marker3D near the river provides for rapid camera positioning for verification of aquatic/stream visuals. While going for a “fly-through” of the planet, the camera will gently transition between Marker3D to Marker3D in order to display terrain.

## Reference

- Godot Documentation 
https://docs.godotengine.org/en/stable/classes/class_marker3d.html

---------------------------------------------------------
# Project Color Addition Explanation: (Jasan Brar)
## Why
- Added color onto the world. Essentially by adding the color, it helped
to shape and envision the world as a proper landscape. 

## World Background
- Breaking it down height by height, anything below a suitable height was darkened, so that
the edges remained looking 'seamless' (6). 

## World Rivers/Streams
- Anything past or equal to a height of (8) on our geometric map would begin to create streams marked by a nice deep blue,
adding onto that anything past or equal to (10) would introduce a richer blue hue to that.

## World Grass/Foliage
- Anything past or equal to a height of (14) would introduce an earthy green which would be enhanced 
by anything past or equal to a height of (18) that would introduce a more muddier green to add richness and
depth to the grassy parts.

## World Mountains
- Anything past or equal to a height of (30) would create the beginnings of a mountain, particulary the hillside,
where it would introduce a light grey. Adding onto that, anything past or equal to a height of (41) would shape
the hue of that grey into a more smokey and traditional mountainside grey, that would be seen more near to the summit.

## World Peaks
- Anything past or equal to a height of (47) would create the beginnings of an icey and snowy peak/mountain top. 
If the height is anything higher than the creation point of the icey/snowy hue then it would automatically default
to a snow white. This would create the perfect illusion of a snowy peaked top onto our geometry map to complete the terrain.

## World Dynamic Lighting
- By adding 'DirectionalLight3D' we greatly enhance the color of the world by making it shine much more than previously before, 
especially the individual hues and more. By adjusting 'DirectionalLight3D' in the energy produced, shading, fog, color, and more 
it helps to customize and adjust that light and sky lighting to better fit the world hue without damaging the environment too much.


## Color References
**Reference of No Color**
- An example of the reference map with no color

https://github.com/j7ysan/GodotTerrainMap/blob/main/nocolor_reference_map0.png

<br>

**Reference of Creating Color**
- An example or examples of the reference map with color being made

https://github.com/j7ysan/GodotTerrainMap/blob/main/baking_map1.png


https://github.com/j7ysan/GodotTerrainMap/blob/main/reference_map1.png


https://github.com/j7ysan/GodotTerrainMap/blob/main/reference_map2.png

---------------------------------------------------------
