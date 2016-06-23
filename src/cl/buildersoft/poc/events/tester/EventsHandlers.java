package cl.buildersoft.poc.events.tester;

import com4j.Com4jObject;
import com4j.ComThread;
import com4j.EventCookie;

public class EventsHandlers extends cl.buildersoft.poc.events.impl.events.__Riser implements
		cl.buildersoft.poc.events.impl.__Riser {
	@Override
	public void intervalEvent(java.lang.String time) {
		try {
			System.out.println("Hora: " + time);
		} catch (Exception e) {
			System.err.println(e);
		}
	}

	@Override
	public <T> EventCookie advise(Class<T> arg0, T arg1) {
		return null;
	}

	@Override
	public void dispose() {

	}

	@Override
	public ComThread getComThread() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public long getIUnknownPointer() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public long getPointer() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int getPtr() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public <T extends Com4jObject> boolean is(Class<T> arg0) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public <T extends Com4jObject> T queryInterface(Class<T> arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void setName(String arg0) {
		// TODO Auto-generated method stub

	}

}
