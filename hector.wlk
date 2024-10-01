import wollok.game.*
import cultivos.*
import aspersores.*
import mercados.*
object hector {
	var property position = game.center()
	const property image = "player.png"
	var property plantacion = granja
	var property cosechados = #{}
	var property oro = 0
	var property comprador = mercados

	// SEMBRAR
	method sembrar(cultivo) {
		self.validarSembrar()
		cultivo.position(position)
		plantacion.agregarCultivo(cultivo)
		game.addVisual(cultivo)
	}

	method validarSembrar() {
		if (not plantacion.sembrados(position).isEmpty()) {
			self.error("¡Ya hay un cultivo en esta parcela!")
		}
	}

	// REGAR
	method regar() {
		self.validarRegar()
		self.cultivos().forEach({cultivo => cultivo.regar()})
	}

	method validarRegar() {
		if (plantacion.sembrados(position).isEmpty()) {
			self.error("¡No hay cultivo para regar en esta parcela!")
		}
	}

	method cultivos() {
		return plantacion.sembrados(position)
	}

	// COSECHAR
	method cosechar() {
		self.validarCosechar()
		self.cultivosCosechables().forEach({cultivo => self.cosechar(cultivo)})
	}

	method cosechar(cultivo) {
		cosechados.add(cultivo)
		game.removeVisual(cultivo)
	}

	method validarCosechar() {
		if (plantacion.sembrados(position).isEmpty()) {
			self.error("¡No hay cultivo para cosechar en esta parcela!")
		}
	}

	method cultivosCosechables() {
		const cosechables = self.cultivos().filter({cultivo => cultivo.cosechable()})
		if (cosechables.isEmpty()) {
			self.error("¡El cultivo todavia no está listo para cosechar!")
		} else {
			return cosechables
		}
	}

	// VENDER
	method vender() {
		self.validarVender()
		comprador.comprar(self)
		oro += self.precioCosecha()
		cosechados.clear()
	}

	method validarVender() {
		if (cosechados.isEmpty()) {
			self.error("¡No hay plantas para vender!")
		}
	}

	method precioCosecha() {
		return cosechados.sum({cultivo => cultivo.precio()})
	}

	method decirGanancia() {
		return "Tengo $" + oro + " y tengo " + cosechados.size() + " plantas"
	}

	// ASPERSORES
	method agregarAspersor() {
		self.validarAgregarAspersor()
		aspersores.crear(position, plantacion)
	}

	method validarAgregarAspersor() {
	  if (not plantacion.sembrados(position).isEmpty()) {
		self.error("¡No se puede colocar un aspersor sobre un cultivo!")
	  }
	}
}

object granja {
	const property cultivosSembrados = #{}

	method agregarCultivo(cultivo) {
		cultivosSembrados.add(cultivo)
	}

	method sembrados(posicion) {
		return cultivosSembrados.filter({cultivo => cultivo.position() == posicion})
	}
}