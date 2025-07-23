extends Furniture

#Override
func similar_rotation() -> bool:
	var low = fmod(holo.rotation.y-rotationThreshold,PI/2)
	var high = fmod(holo.rotation.y+rotationThreshold,PI/2)
	var rot = fmod(rotation.y,PI/2)
	if(rot < -PI/4):
		rot += PI/2
	elif(rot > PI/4):
		rot -= PI/2
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
