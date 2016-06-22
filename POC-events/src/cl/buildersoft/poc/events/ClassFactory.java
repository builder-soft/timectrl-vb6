package cl.buildersoft.poc.events  ;

import com4j.*;

/**
 * Defines methods to create COM objects
 */
public abstract class ClassFactory {
  private ClassFactory() {} // instanciation is not allowed


  public static cl.buildersoft.poc.events._Riser createRiser() {
    return COM4J.createInstance( cl.buildersoft.poc.events._Riser.class, "{E074DE35-BC13-48C8-BFE0-025E5D02FEA1}" );
  }
}
