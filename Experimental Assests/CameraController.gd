extends Node

#Set variables that attach themselves to the Yaw, Pitch and Camera Nodes
@onready var yaw_node = $CamYaw
@onready var pitch_node = $CamYaw/CamPitch
@onready var camera = $CamYaw/CamPitch/Camera3D

#Set variables of yar and pitch of the camera 
var yaw: float = 0
var pitch: float = 0

#Set variables of the sensitivities of yar and pitch of the camera
#Changing these variables will change the senitivity of the camera's
var yaw_sensitivity : float = 0.07
var pitch_sensitivity : float = 0.07

#Set variables of the acceleration, I.E zoom
var yaw_acceleration : float = 15
var pitch_acceleration : float = 15

#Variables, max and min to be used in a function to avoid camera from going too far on screen
var max_pitch : float = 75
var min_pitch : float = -55

#Simple void function that hides the cursor of the mouse when the input of movement
#specifically for this scene and when on screen of this scene
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

#Function that reacts to mouse movement relative to the last frame of mouse
#motion
func _input(event):
	if event is InputEventMouseMotion:
		yaw += event.relative.x * yaw_sensitivity
		pitch += event.relative.y * pitch_sensitivity

#This function acts as the physics of the Camera
func _physics_process(delta):
	#Clamp that uses min and max variables and forces camera to only rotate a certain amount
	pitch = clamp(pitch, min_pitch, max_pitch)
	
	#Lerp is difficult to explain in essence is an overtime movement across two points
	yaw_node.rotation_degrees.y = lerp(yaw_node.rotation_degrees.y, yaw, yaw_acceleration * delta)
	pitch_node.rotation_degrees.x = lerp(pitch_node.rotation_degrees.x, pitch, pitch_acceleration * delta)
	
	#Unsmoothens the camera and allows for a better more blocky camera approach
	yaw_node.rotation_degrees.y = yaw
	pitch_node.rotation_degrees.x = pitch


