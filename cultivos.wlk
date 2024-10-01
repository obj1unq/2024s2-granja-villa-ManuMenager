import wollok.game.*

class Maiz {
	var property estado = baby
	var property position = null

	method image() {
		// TODO: hacer que devuelva la imagen que corresponde
		return "corn_" + estado + ".png"
	}

	method regar() {
		estado = adult
	}

	method cosechable() {
		return estado.cosechable()
	}

	method precio() {
		return 150
	}
}

object baby {
	method cosechable() {
		return false
	}
}

object adult {
	method cosechable() {
		return true
	}
}

class Trigo {
	var property position = null
	var property etapa = 0
	

	method image() {
		return "wheat_"+ etapa + ".png"
	}

	method regar() {
		if (etapa < 3) {
			etapa += 1
		} else {
			etapa = 0
		}
	}

	method cosechable() {
		return etapa >= 2
	}

	method precio() {
		return (etapa - 1) * 100
	}
}

class Tomaco {
	var property position = null

	method image() {
		return "tomaco.png"
	}

	method regar() {
		position = game.at(position.x(), self.siguienteY())
	}

	method siguienteY() {
		if (game.height() - 1 != position.y()) {
			return position.y() + 1
		} else {
			return 0
		}
	}

	method cosechable() {
		return true
	}

	method precio() {
		return 80
	}
}