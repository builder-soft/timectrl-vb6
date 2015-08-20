package cl.buildersoft.timectrl.api  ;

import com4j.*;

/**
 * Defines methods to create COM objects
 */
public abstract class ClassFactory {
  private ClassFactory() {} // instanciation is not allowed


  public static cl.buildersoft.timectrl.api._zkemProxy createzkemProxy() {
    return COM4J.createInstance( cl.buildersoft.timectrl.api._zkemProxy.class, "{B010C527-776A-4158-B10C-EB4F31B22213}" );
  }
}
