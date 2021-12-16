import wollok.game.*
import scalonetaInGame.*
import objetosRandoms.*
import backGroundsYSounds.*

object messi {

	const nombre = "Lionel"
	var property vidas = 3
	var property position = new Position(x = 0, y = 0)

	method image() = "messi.png"

	method teQuedasteSinVida() = vidas <= 0

	method irA(nuevaPosicion) {
		position = nuevaPosicion
		self.corregirPosition()
	}

	method corregirPosition() {
		position = new Position(x = (position.x().max(0)).min(12), y = 0)
	}

	method perderVidas(cantidad) {
		vidas -= cantidad
	}

	method recuperarVidas(cantidad) {
		if (self.vidas() < 3) vidas = (vidas + cantidad).min(3)
	}

	method meChocoAlguien(objeto) {
		return objeto.position() == self.position()
	}

}

