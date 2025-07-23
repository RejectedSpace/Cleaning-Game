extends Furniture

#Override
func similar_rotation() -> bool:
	var low = fmod(holo.rotation.y-rotationThreshold,PI)
	var high = fmod(holo.rotation.y+rotationThreshold,PI)
	var rot = fmod(rotation.y,PI)
	if(rot < -PI/2):
		rot += PI
	elif(rot > PI/2):
		rot -= PI
	if(low < high and (rot < low or rot > high)):
		return false
	elif(low > high and rot > low and rot < high):
		return false
	low = fmod(holo.rotation.z-rotationThreshold,PI)
	high = fmod(holo.rotation.z+rotationThreshold,PI)
	rot = fmod(rotation.z,PI)
	if(rot < -PI/2):
		rot += PI
	elif(rot > PI/2):
		rot -= PI
	if(low < high and (rot < low or rot > high)):
		return false
	elif(low > high and rot.z > low and rot.z < high):
		return false
	return rotation.x - holo.rotation.x <= rotationThreshold
