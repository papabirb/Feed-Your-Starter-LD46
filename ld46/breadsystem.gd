extends Node


# Declare member variables here. Examples:
var maxHealth = 100
var health = maxHealth
var flourPercent = 100
var waterPercent = 100
var decreaseAmount = 4
var increaseAmount = 2
var dead = false
var score = 0

onready var watTimer = $WaterTimer
onready var foodTimer = $FoodTimer 
onready var hpTimer = $HealthTimer
onready var diffTimer = $DifficultyTimer
onready var healTimer = $HealTimer
onready var animTimer = $AnimTimer
onready var scoreTimer = $"Score timer"
onready var bgMusic = $Music
onready var vwoop = $VWOOP
onready var tchu = $tchu


# Called when the node enters the scene tree for the first time.
func _ready():
	watTimer.start()
	foodTimer.start()
	hpTimer.start()
	diffTimer.start()
	healTimer.start()
	animTimer.start()
	scoreTimer.start()
	$"Score number".text = str(score) + " seconds"
	bgMusic.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$HP.value = health
	$WaterHP.value = waterPercent
	$FoodHP.value = flourPercent	
	$"Score number".text = str(score) + " seconds"
	if health <= 0:
		scoreTimer.stop()
		bgMusic.stop()
		dead = true
		$FEED.disabled = true
		$MOIST.disabled = true
		$FEED.visible = false
		$MOIST.visible = false
		watTimer.stop()
		foodTimer.stop()
		hpTimer.stop()
		diffTimer.stop()
		healTimer.stop()


func _on_WaterTimer_timeout():
	waterPercent -= decreaseAmount
	if waterPercent < 0:
		waterPercent = 0


func _on_FoodTimer_timeout():
	flourPercent -= decreaseAmount
	if flourPercent < 0:
		flourPercent = 0


func _on_HealthTimer_timeout():
	#watTimer.start()
	#foodTimer.start()
	var damage = 0
	if flourPercent < 90 and flourPercent >= 80:
		damage += 1
	if waterPercent < 90 and waterPercent >= 80:
		damage += 1
	if flourPercent < 80 and flourPercent >= 70:
		damage += 2
	if waterPercent < 80 and flourPercent >= 70:
		damage += 2
	if flourPercent < 70:
		damage += 5
	if waterPercent < 70:
		damage += 5
	if (health - damage) < 0:
		health = 0
	if (health - damage) > 0:
		health -= damage
	#watTimer.start()
	#foodTimer.start()


func _on_DifficultyTimer_timeout():
	if decreaseAmount < 30:
		decreaseAmount += 1
	if increaseAmount < 15:
		increaseAmount += 1


func _on_HealTimer_timeout():
	if flourPercent <= 100 and flourPercent >= 85 and waterPercent <= 100 and waterPercent >= 85 and health < 100:
		health += increaseAmount


func _on_FEED_pressed():
	if (flourPercent + increaseAmount > 100):
		flourPercent = 100
	else:
		flourPercent += increaseAmount
		tchu.play()


func _on_MOIST_pressed():
	if (waterPercent + increaseAmount > 100):
		waterPercent = 100
	else:
		waterPercent += increaseAmount
		vwoop.play()

func _on_AnimTimer_timeout():
	if health >= 90 and $Starter.animation != "happy":
		$Starter.animation = "happy"
	if health < 90 and health >= 60 and $Starter.animation != "not good":
		$Starter.animation = "not good"
	if health < 60 and health >= 30 and $Starter.animation != "bad":
		$Starter.animation = "bad"
	if health == 0:
		$Starter.animation = "dead"
		animTimer.stop()


func _on_Starter_animation_finished():
	if $Starter.animation == "dead":
		$Health.visible = false
		$Flour.visible = false
		$Water.visible = false
		$HP.visible = false
		$WaterHP.visible = false
		$FoodHP.visible = false
		$Death.visible = true
		$Restart.visible = true
		$Restart.disabled = false

func _on_Restart_pressed():
	var _reset = get_tree().reload_current_scene()


func _on_Score_timer_timeout():
	score += 1
