import wollok.game.*
import scalonetaInGame.*
import messi.*
import backGroundsYSounds.*



class Randoms {

	var property position = game.origin()

	method image()

	method choqueAMessi()

	method restarVidasCuandoCae()

	method asignarNuevaVelocidad()

	method perderAltura() {
		position = position.down(1)
		self.corregirPosicion()
	}

	method corregirPosicion() {
		if (self.salioDelTablero()) {
			messi.perderVidas(self.restarVidasCuandoCae())
			scalonetaInGame.chequearEstadoDeJuego()
			self.restaurarPosition()
		}
	}

	method restaurarPosition() {
		position = new Position(x = 0.randomUpTo(11).roundUp(), y = 9)
		self.asignarNuevaVelocidad()
	}

	method salioDelTablero() {
		return self.position().y() == -1
	}

}

object kiko inherits Randoms(position = new Position(x = 1.randomUpTo(10).roundUp(), y = 9)) {
	override method image() = "kiko.png"

	override method asignarNuevaVelocidad() {
		if (scalonetaInGame.enJuego()) {
			game.removeTickEvent("caeKiko")
			game.onTick(scalonetaInGame.velocidadRandom(), "caeKiko", { self.perderAltura()})
		}
	}

	override method restarVidasCuandoCae() = 1

	override method choqueAMessi() {
		game.sound("vamoniubel.mp3").play()
		messi.recuperarVidas(3)
		score.sumarScore(200)
	}

}

object china inherits Randoms(position = new Position(x = 1.randomUpTo(10).roundUp(), y = 9)) {

	override method image() = "china.png"

	override method asignarNuevaVelocidad() {
		if (scalonetaInGame.enJuego()) {
			game.removeTickEvent("caeChina")
			game.onTick(scalonetaInGame.velocidadRandom(), "caeChina", { self.perderAltura()})
		}
	}

	override method restarVidasCuandoCae() = 0

	override method choqueAMessi() {
		game.sound("chan.mp3").play()
		game.say(messi, "me gustan los casados")
		messi.perderVidas(1)
	}

}

object dePaul inherits Randoms(position = new Position(x = 1.randomUpTo(10).roundUp(), y = 9)) {

	override method image() = "depaul.png"

	override method asignarNuevaVelocidad() {
		if (scalonetaInGame.enJuego()) {
			game.removeTickEvent("caeDePaul")
			game.onTick(scalonetaInGame.velocidadRandom(), "caeDePaul", { self.perderAltura()})
		}
	}

	override method restarVidasCuandoCae() = 1

	override method choqueAMessi() {
		score.sumarScore(100)
	}

}

object rickyFort inherits Randoms(position = new Position(x = 1.randomUpTo(10).roundUp(), y = 9)) {

	override method image() = "rickyFort.png"

	override method asignarNuevaVelocidad() {
		if (scalonetaInGame.enJuego()) {
			game.removeTickEvent("caeRickyFort")
			game.onTick(scalonetaInGame.velocidadRandom(), "caeRickyFort", { self.perderAltura()})
		}
	}

	override method restarVidasCuandoCae() = 1

	override method choqueAMessi() {
		game.say(messi, "MIAMEEEEEE")
		score.sumarScore(500)
	}

}

object antonella inherits Randoms(position = new Position(x = 1.randomUpTo(10).roundUp(), y = 9)) {

	override method image() = "antonella.png"

	override method asignarNuevaVelocidad() {
		if (scalonetaInGame.enJuego()) {
			game.removeTickEvent("caeAntonella")
			game.onTick(scalonetaInGame.velocidadRandom(), "caeAntonella", { self.perderAltura()})
		}
	}

	override method restarVidasCuandoCae() = 1

	override method choqueAMessi() {
		messi.recuperarVidas(1)
		score.sumarScore(300)
	}

}

object mirtaLegrand inherits Randoms(position = new Position(x = 1.randomUpTo(10).roundUp(), y = 9)) {

	override method image() = "mirtaLegrand.png"

	override method asignarNuevaVelocidad() {
		if (scalonetaInGame.enJuego()) {
			game.removeTickEvent("caeMirtaLegrand")
			game.onTick(scalonetaInGame.velocidadRandom(), "caeMirtaLegrand", { self.perderAltura()})
		}
	}

	override method restarVidasCuandoCae() = 0

	override method choqueAMessi() {
		configuracion.perdioPorMirtha()
		scalonetaInGame.enJuego(false)
	}

}



