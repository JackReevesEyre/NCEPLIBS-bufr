//
// This file was generated by the JavaTM Architecture for XML Binding(JAXB) Reference Implementation, vJAXB 2.1.10 in JDK 6 
// See <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// Any modifications to this file will be lost upon recompilation of the source schema. 
// Generated on: 2016.06.16 at 05:13:08 PM GMT-05:00 
//


package TableD26.jabx;

import java.util.ArrayList;
import java.util.List;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlSchemaType;
import javax.xml.bind.annotation.XmlType;
import javax.xml.datatype.XMLGregorianCalendar;


/**
 * <p>Java class for anonymous complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType>
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element ref="{}BUFR_26_0_0_TableD_en" maxOccurs="unbounded" minOccurs="0"/>
 *       &lt;/sequence>
 *       &lt;attribute name="generated" type="{http://www.w3.org/2001/XMLSchema}dateTime" />
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = {
    "bufr2600TableDEn"
})
@XmlRootElement(name = "dataroot")
public class Dataroot {

    @XmlElement(name = "BUFR_26_0_0_TableD_en")
    protected List<BUFR2600TableDEn> bufr2600TableDEn;
    @XmlAttribute
    @XmlSchemaType(name = "dateTime")
    protected XMLGregorianCalendar generated;

    /**
     * Gets the value of the bufr2600TableDEn property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the bufr2600TableDEn property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getBUFR2600TableDEn().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link BUFR2600TableDEn }
     * 
     * 
     */
    public List<BUFR2600TableDEn> getBUFR2600TableDEn() {
        if (bufr2600TableDEn == null) {
            bufr2600TableDEn = new ArrayList<BUFR2600TableDEn>();
        }
        return this.bufr2600TableDEn;
    }

    /**
     * Gets the value of the generated property.
     * 
     * @return
     *     possible object is
     *     {@link XMLGregorianCalendar }
     *     
     */
    public XMLGregorianCalendar getGenerated() {
        return generated;
    }

    /**
     * Sets the value of the generated property.
     * 
     * @param value
     *     allowed object is
     *     {@link XMLGregorianCalendar }
     *     
     */
    public void setGenerated(XMLGregorianCalendar value) {
        this.generated = value;
    }

}