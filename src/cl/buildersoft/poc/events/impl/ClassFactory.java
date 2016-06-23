package cl.buildersoft.poc.events.impl  ;

import com4j.*;

/**
 * Defines methods to create COM objects
 */
public abstract class ClassFactory {
  private ClassFactory() {} // instanciation is not allowed


  public static cl.buildersoft.poc.events.impl._Riser createRiser() {
    return COM4J.createInstance( cl.buildersoft.poc.events.impl._Riser.class, "{2F0AD8C9-B097-42F4-97E7-C76BA42F2364}" );
  }
}
