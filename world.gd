extends Node3D
var size:Vector2i = Vector2(500,500)

func _ready():
	#set up image and make black border
	var noise_image:Image = $Noise.texture.noise.get_image(size.x,size.y,false,false,false)
	for i in size.x:
		noise_image.set_pixel(i,0,Color.BLACK)
		noise_image.set_pixel(i,size.y - 1,Color.BLACK)
		noise_image.set_pixel(0,i,Color.BLACK)
		noise_image.set_pixel(size.x - 1,i,Color.BLACK)
	
	#2d array so i dont have to do math to figure out indecies
	var verts= [[]]
	verts.resize(size.x)
	for i in size.x:
		verts[i] = PackedInt32Array([])
		verts[i].resize(size.y)
	
	#use surface tool to add verticies for each pixel of the noise image. height of verticies is set to the brightness of the pixel
	var st:SurfaceTool = SurfaceTool.new()
	st.begin(Mesh.PRIMITIVE_TRIANGLES);
	var c = 0
	
	for y in size.y:
		for x in size.x:
		# Our previously used code for creating map height
			var height = noise_image.get_pixel(x,y).r * 64
		# Standard color which can be manipulated to add color depth to our world
			var heightAdjustedColor = Color(0, 0, 0)
		# Standard height variable for individual usage
			var z = height
		
		# World Background
			if height <= 6:
				heightAdjustedColor = Color(0, 0, 0)
		# World River/Streams Hue
			elif height <= 8:
				heightAdjustedColor = Color(0.2,0.5,0.8)
		# Enriching River/Streams Hue
			elif height <= 10:
				heightAdjustedColor = Color(0.2,0.55,0.8)
		# World Grass/Foliage Hue
			elif height <= 14:
				heightAdjustedColor = Color(0.3,0.6,0.1)
		# Enriching World Grass/Foliage Hue
			elif height <= 18:
				heightAdjustedColor = Color(0.3,0.51,0.1)
		# World Mountain Hue
			elif height <= 30:
				heightAdjustedColor = Color(0.57,0.55,0.57)
		# World Mountain Top Hue
			elif height <= 41:
				heightAdjustedColor = Color(0.52, 0.5, 0.52)
		# World Mountain Top - Summit Hue
			elif height <= 47:
				heightAdjustedColor = Color(0.7, 0.85,1.0)
		# World Mountain Top - Summit - Peak Hue
			else:
				heightAdjustedColor = Color(1.0, 1.0, 1.0)
			
		# Adding in our customized heightAdjustedColor map
			st.set_color(heightAdjustedColor)
		# Adding in our vertex but adjusting the hardcoded height to a simpler variable addition of the height
			st.add_vertex(Vector3(x, z, y))
			
			verts[x][y] = c
			c += 1
	
	#use surface tool to make 2 triangles (1 square) for each pixel
	for y in size.y-1:
		for x in size.x-1:
			st.add_index(verts[x][y])
			st.add_index(verts[x+1][y])
			st.add_index(verts[x][y+1])
			
			st.add_index(verts[x+1][y])
			st.add_index(verts[x+1][y+1])
			st.add_index(verts[x][y+1])
	
	st.index()
	st.generate_normals()
	st.generate_tangents()
	
	$Marker3D.position = Vector3(noise_image.get_width(),0,noise_image.get_height()) / 2 #center camera
	$MeshInstance3D.mesh = st.commit()

func _input(event):
	if event is InputEventMouseMotion:
		if event.button_mask == MOUSE_BUTTON_MASK_RIGHT:
			var x = event.relative.rotated(-$Marker3D.rotation.y+(PI/2))
			var pos_vec = Vector2($Marker3D.position.x,$Marker3D.position.z)
			
			pos_vec += (x * $Marker3D/Camera3D.position.y) / 1500
			$Marker3D.position.x = pos_vec.x
			$Marker3D.position.z = pos_vec.y

func _physics_process(_delta):
	var x = Input.get_axis("left","right")
	var y = Input.get_axis("up","down")
	if x: $Marker3D.position.x += x * 5
	if y: $Marker3D.position.z += y * 5
	
	$Marker3D.rotation.y += 0.0025
