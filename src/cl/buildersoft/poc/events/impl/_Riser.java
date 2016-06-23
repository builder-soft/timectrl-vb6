package cl.buildersoft.poc.events.impl  ;

import com4j.*;

@IID("{E085DE87-D1B7-46AB-A85E-31B42EBCA3F0}")
public interface _Riser extends Com4jObject {
  // Methods:
  /**
   */

  @DISPID(1610809349) //= 0x60030005. The runtime will prefer the VTID if present
  @VTID(10)
  void start();


  /**
   */

  @DISPID(1610809351) //= 0x60030007. The runtime will prefer the VTID if present
  @VTID(11)
  void stopMe();


  /**
   * @param message Mandatory Holder<java.lang.String> parameter.
   */

  @DISPID(1610809352) //= 0x60030008. The runtime will prefer the VTID if present
  @VTID(12)
  void writeToLog(
    Holder<java.lang.String> message);


  // Properties:
}
