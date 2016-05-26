package cl.buildersoft.timectrl.api  ;

import com4j.*;

/**
 * Defines methods to create COM objects
 */
public abstract class ClassFactory {
  private ClassFactory() {} // instanciation is not allowed


  public static cl.buildersoft.timectrl.api._zkemProxy createzkemProxy() {
    return COM4J.createInstance( cl.buildersoft.timectrl.api._zkemProxy.class, "{5F0392F7-1569-4392-ACC3-83C2BA634650}" );
  }

  public static cl.buildersoft.timectrl.api._zkemEvent createzkemEvent() {
    return COM4J.createInstance( cl.buildersoft.timectrl.api._zkemEvent.class, "{42C6918A-B539-4CC8-972C-BCA160B83EAB}" );
  }

  /**
   * ZKEM Class
   */
  public static cl.buildersoft.timectrl.api.IZKEM createCZKEM() {
    return COM4J.createInstance( cl.buildersoft.timectrl.api.IZKEM.class, "{00853A19-BD51-419B-9269-2DABE57EB61F}" );
  }
}
