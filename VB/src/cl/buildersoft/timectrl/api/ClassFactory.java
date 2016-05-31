package cl.buildersoft.timectrl.api  ;

import com4j.*;

/**
 * Defines methods to create COM objects
 */
public abstract class ClassFactory {
  private ClassFactory() {} // instanciation is not allowed


  /**
   * ZKEM Class
   */
  public static cl.buildersoft.timectrl.api.IZKEM createCZKEM() {
    return COM4J.createInstance( cl.buildersoft.timectrl.api.IZKEM.class, "{00853A19-BD51-419B-9269-2DABE57EB61F}" );
  }

  public static cl.buildersoft.timectrl.api._zkemProxy createzkemProxy() {
    return COM4J.createInstance( cl.buildersoft.timectrl.api._zkemProxy.class, "{69B0CFE9-91D4-40AD-820E-E5658A3CB0C3}" );
  }
}
