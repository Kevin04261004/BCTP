# HeroBaseState.gd
extends BaseState
class_name HeroBaseState

# =========================
# Components
# =========================

var hero: Hero

# =========================
# Lifecycle
# =========================

func setup():
	super()
	hero = root as Hero
