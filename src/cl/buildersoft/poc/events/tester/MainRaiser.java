package cl.buildersoft.poc.events.tester;

import cl.buildersoft.poc.events.impl.ClassFactory;
import cl.buildersoft.poc.events.impl._Riser;
import cl.buildersoft.poc.events.impl.events.__Riser;

import com4j.EventCookie;

public class MainRaiser {

	/**
	 * @param args
	 * @throws InterruptedException
	 */
	public static void main(String[] args) throws InterruptedException {
		EventsHandlers anyInstance = new EventsHandlers();
		_Riser comObject = ClassFactory.createRiser();

		// EventCookie cookie = comObject.advise(__Riser.class, new __Riser() {

		EventCookie cookie = comObject.advise(__Riser.class, anyInstance);

		comObject.start();

		Thread.sleep(1000 * 3);

		comObject.stopMe();
		cookie.close();

	}

}
