
package com.redsum.bos.ws;

import javax.xml.bind.JAXBElement;
import javax.xml.bind.annotation.XmlElementDecl;
import javax.xml.bind.annotation.XmlRegistry;
import javax.xml.namespace.QName;


/**
 * This object contains factory methods for each 
 * Java content interface and Java element interface 
 * generated in the com.redsum.bos.ws package. 
 * <p>An ObjectFactory allows you to programatically 
 * construct new instances of the Java representation 
 * for XML content. The Java representation of XML 
 * content can consist of schema derived interfaces 
 * and classes representing the binding of schema 
 * type definitions, element declarations and model 
 * groups.  Factory methods for each of these are 
 * provided in this class.
 * 
 */
@XmlRegistry
public class ObjectFactory {

    private final static QName _AddWaybill_QNAME = new QName("http://ws.bos.redsum.com/", "addWaybill");
    private final static QName _WaybilldetailList_QNAME = new QName("http://ws.bos.redsum.com/", "waybilldetailList");
    private final static QName _WaybilldetailListResponse_QNAME = new QName("http://ws.bos.redsum.com/", "waybilldetailListResponse");
    private final static QName _AddWaybillResponse_QNAME = new QName("http://ws.bos.redsum.com/", "addWaybillResponse");

    /**
     * Create a new ObjectFactory that can be used to create new instances of schema derived classes for package: com.redsum.bos.ws
     * 
     */
    public ObjectFactory() {
    }

    /**
     * Create an instance of {@link AddWaybill }
     * 
     */
    public AddWaybill createAddWaybill() {
        return new AddWaybill();
    }

    /**
     * Create an instance of {@link AddWaybillResponse }
     * 
     */
    public AddWaybillResponse createAddWaybillResponse() {
        return new AddWaybillResponse();
    }

    /**
     * Create an instance of {@link WaybilldetailList }
     * 
     */
    public WaybilldetailList createWaybilldetailList() {
        return new WaybilldetailList();
    }

    /**
     * Create an instance of {@link WaybilldetailListResponse }
     * 
     */
    public WaybilldetailListResponse createWaybilldetailListResponse() {
        return new WaybilldetailListResponse();
    }

    /**
     * Create an instance of {@link Waybilldetail }
     * 
     */
    public Waybilldetail createWaybilldetail() {
        return new Waybilldetail();
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link AddWaybill }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://ws.bos.redsum.com/", name = "addWaybill")
    public JAXBElement<AddWaybill> createAddWaybill(AddWaybill value) {
        return new JAXBElement<AddWaybill>(_AddWaybill_QNAME, AddWaybill.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link WaybilldetailList }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://ws.bos.redsum.com/", name = "waybilldetailList")
    public JAXBElement<WaybilldetailList> createWaybilldetailList(WaybilldetailList value) {
        return new JAXBElement<WaybilldetailList>(_WaybilldetailList_QNAME, WaybilldetailList.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link WaybilldetailListResponse }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://ws.bos.redsum.com/", name = "waybilldetailListResponse")
    public JAXBElement<WaybilldetailListResponse> createWaybilldetailListResponse(WaybilldetailListResponse value) {
        return new JAXBElement<WaybilldetailListResponse>(_WaybilldetailListResponse_QNAME, WaybilldetailListResponse.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link AddWaybillResponse }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://ws.bos.redsum.com/", name = "addWaybillResponse")
    public JAXBElement<AddWaybillResponse> createAddWaybillResponse(AddWaybillResponse value) {
        return new JAXBElement<AddWaybillResponse>(_AddWaybillResponse_QNAME, AddWaybillResponse.class, null, value);
    }

}
