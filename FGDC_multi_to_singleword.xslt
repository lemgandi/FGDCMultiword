<!--
   Convert multi-word address values to sets of single-word values for use with the python "usaddress" parser.
Propers to    http://www.abbeyworkshop.com/howto/xslt/xslt-split-values/index.html for the cute recursive
template design.

This template currently outputs the following fields:

AddressNumberPrefix
AddressNumber
AddressNumberSuffix
StreetNamePreModifier
StreetNamePreDirectional
StreetNamePretype
StreetNamePreTypeSeparator*
StreetName*
StreetNamePostType
StreetNamePostDirectional
StreetNamePostModifier
PlaceName*
Statename*
ZipCode

* These fields are broken up into single words. So, for example, the input xml <StateName>North Carolina</StateName>
becomes <StateName>North</StateName><StateName>Carolina</StateName> in the output file.

Copyright January 2016 Spatial Focus LLC

This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   version="1.0">
 
<!-- comment the next line out if you want to be compact. -->
<xsl:output indent="yes" method="xml"/> 
 
<xsl:template match="/">
 <AddressCollection>
  <xsl:for-each select="/AddressCollection/AddressString">
     <AddressString>
     <xsl:if test="AddressNumberPrefix">
        <AddressNumberPrefix>
        <xsl:value-of select="AddressNumberPrefix"/>
        </AddressNumberPrefix>
     </xsl:if> 
     <AddressNumber>
       <xsl:value-of select="AddressNumber"/>
     </AddressNumber>
     <xsl:if test="AddressNumberSuffix">
        <AddressNumberSuffix>
        <xsl:value-of select="AddressNumberSuffix"/>
        </AddressNumberSuffix>
     </xsl:if> 
     <xsl:if test="StreetNamePreModifier">
        <StreetNamePreModifier>
        <xsl:value-of select="StreetNamePreModifier"/>
        </StreetNamePreModifier>
     </xsl:if>

     <xsl:if test="StreetNamePreDirectional">
        <StreetNamePreDirectional>
          <xsl:value-of select="StreetNamePreDirectional"/>
        </StreetNamePreDirectional>
     </xsl:if>
     <xsl:if test="StreetNamePreType">
        <StreetNamePreType>
        <xsl:value-of select="StreetNamePreType"/>
        </StreetNamePreType>
     </xsl:if>
     <xsl:if test="StreetNamePreTypeSeparator">
        <xsl:call-template name="output-tokens">
           <xsl:with-param name="tokname">StreetNamePreTypeSeparator</xsl:with-param>
           <xsl:with-param name="whole"><xsl:value-of select="StreetNamePreTypeSeparator"/></xsl:with-param>
        </xsl:call-template>
     </xsl:if>     
     <xsl:call-template name="output-tokens">
       <xsl:with-param name="tokname">StreetName</xsl:with-param>
       <xsl:with-param name="whole"><xsl:value-of select="StreetName" /></xsl:with-param>
     </xsl:call-template>
     <xsl:if test="StreetNamePostType">
        <StreetNamePostType>
        <xsl:value-of select="StreetNamePostType"/>
        </StreetNamePostType>
     </xsl:if>
          <xsl:if test="StreetNamePostDirectional">
        <StreetNamePostDirectional>
        <xsl:value-of select="StreetNamePostDirectional"/>
        </StreetNamePostDirectional>
     </xsl:if>
     <xsl:if test="StreetNamePostModifier">
        <StreetNamePostModifier>
        <xsl:value-of select="StreetNamePostModifier"/>
        </StreetNamePostModifier>
     </xsl:if>
     <xsl:if test="PlaceName">
        <xsl:call-template name="output-tokens">
           <xsl:with-param name="tokname">PlaceName</xsl:with-param>
           <xsl:with-param name="whole"><xsl:value-of select="PlaceName"/></xsl:with-param>
        </xsl:call-template>

     </xsl:if>
     <xsl:if test="StateName">
         <xsl:call-template name="output-tokens">
           <xsl:with-param name="tokname">StateName</xsl:with-param>
           <xsl:with-param name="whole"><xsl:value-of select="StateName"/></xsl:with-param>
        </xsl:call-template>
     </xsl:if>
     <xsl:if test="ZipCode">
        <ZipCode>
        <xsl:value-of select="ZipCode"/>
        </ZipCode>
     </xsl:if>
    </AddressString>
    </xsl:for-each>
</AddressCollection>

</xsl:template>
 
<xsl:template name="output-tokens">
     <xsl:param name="tokname"/>
     <xsl:param name="whole" />
     <xsl:variable name="newlist" select="concat(normalize-space($whole), ' ')" />
     <xsl:variable name="first" select="substring-before($newlist, ' ')" />
     <xsl:variable name="remaining" select="substring-after($newlist, ' ')" />
     <xsl:element name="{$tokname}"><xsl:value-of select="$first" /></xsl:element>
     <xsl:if test="$remaining">
         <xsl:call-template name="output-tokens">
             <xsl:with-param name="whole" select="$remaining" />
             <xsl:with-param name="tokname" select="$tokname"/>
         </xsl:call-template>
     </xsl:if>
</xsl:template>

</xsl:stylesheet>
 
