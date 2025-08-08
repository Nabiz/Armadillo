extends Area3D

var interpolate_cam = false
var player_cam = null
var playerball_cam= null
var t=0.0

func _physics_process(delta: float) -> void:
	if interpolate_cam:
		t+= delta * 0.6
		player_cam.position.z = clampf(lerpf(6.0, 15.0, t),6.0, 15.0)
		playerball_cam.position.z = clampf(lerpf(6.0, 15.0, t),6.0, 15.0)
	else:
		if player_cam and playerball_cam:
			t+= delta
			player_cam.position.z = clampf(lerpf(15.0, 6.0, t),6.0, 15.0)
			playerball_cam.position.z = clampf(lerpf(15.0, 6.0, t),6.0, 15.0)

func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		#t=0
		var p = body as Player
		#interpolate_cam = true
		#player_cam = p.camera
		#playerball_cam = p.player_ball.ball_camera
	elif body is PlayerBall:
		#t=0
		interpolate_cam = true
		var pb = body as PlayerBall
		player_cam = pb.player.camera
		playerball_cam = pb.ball_camera


func _on_body_exited(body: Node3D) -> void:
	if body is Player:
		t = 0
		interpolate_cam = false
