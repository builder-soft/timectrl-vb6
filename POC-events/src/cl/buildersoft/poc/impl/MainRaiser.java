package cl.buildersoft.poc.events.impl;

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

		EventCookie cookie = comObject.advise(cl.buildersoft.poc.events.impl.__Riser.class, anyInstance);

		comObject.start();

		Thread.sleep(1000 * 15);

		comObject.stopMe();
		cookie.close();

	}

}
