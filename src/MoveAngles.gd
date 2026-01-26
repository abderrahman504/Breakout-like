extends Resource
class_name MoveAngles

## This resource stores the angles that an object can move in.
## It is also used to help clamp a given angle to one of those movement angles.

## The angles that an object may move in in degrees.
@export var movement_angles : PackedFloat32Array = []


## Returns the movement angle closest to [code]angle_degrees[/code]
func clamp_angle_degrees(angle_degrees : float) -> float:
	angle_degrees = fposmod(angle_degrees, 360.)
	var best_dif := INF
	var best_i : int = 0
	for i in range(movement_angles.size()):
		var dif : float = abs(angle_degrees - movement_angles[i])
		var dif_1 : float = abs(angle_degrees + 360 - movement_angles[i])
		var dif_2 : float = abs(angle_degrees - 360 - movement_angles[i])
		dif = min(dif, min(dif_1, dif_2))

		if dif < best_dif:
			best_i = i
			best_dif = dif
	return movement_angles[best_i]


func clamp_angle_radian(angle_radian : float) -> float:
	return clamp_angle_degrees(angle_radian * 180/PI) * PI/180
