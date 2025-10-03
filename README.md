# Group_2-Comp_360-Assignment_1
Assignment 1 for COMP 360 from Group 2

<br>

# GROUP 2 - COMP 360 - ON1 - GROUP EXPLANATION
# Project Init:

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
# Project Marker3D Explanation:

---------------------------------------------------------
# Project Environment Explanation: (Bhav)

## Creation
The environment of the project was initialized upon adding a standard colorwave onto the geometry we 
had already established. Once realizing the possibility of the world building we could do from it, we added
in the proper use of shadows, lighting, and more to bring it more life for when we add in the colors of the world.

## Usage
The lighting was set to that akin of the sun's light, but nothing too major as to obstruct the constructed colors.
The energy and indirect energy was skewed due to this fact so that the light may fall favorably as to also showcase
the roughness of the material we were using for the world's environment. This is because without light, the world seemed
a lot more lifeless, and more importantly, smooth and underdeveloped. 

## Further Usage
By adding in volumetric fog and a better black border, it helped to separate the difference between each segment of the 
environment. We added in a directional shadow as well with blend splits to help distinguish the finer spots on the map, 
which assisted in blending in the various color hues we had made with one another. 

## In Conjuction with Camera3D
Most importantly, the position of these additions was only slightly altered off the camera as to give it more of a
"from above" perspective, so that the view is of the sun being up and above even the watcher.

## Environment References
**Reference of No Environment Additions**
<br> 
- An example of the reference map with no light or shadows being added
<br>
https://github.com/j7ysan/GodotTerrainMap/blob/main/no_light_reference1.png


**Reference of Added Environment Variables**
<br> 
- An example or examples of the reference map with light and shadows being added
<br>
https://github.com/j7ysan/GodotTerrainMap/blob/main/with_light_reference2.png

---------------------------------------------------------
# Project Marker3D Explanation: (Manmeet)

## Why

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
