<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:mods="http://www.loc.gov/mods/v3" exclude-result-prefixes="mods dc xsi oai_dc srw_dc" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:dc="http://purl.org/dc/elements/1.1/"
  xmlns:srw_dc="info:srw/schema/1/dc-schema" xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!--
This stylesheet transforms MODS into HTML for public facing display of MODS metadata in Islandora.
Originally derived from a MODS to DC converter. (credit: Version 1.0, 2007-05-04 Tracy Meehleib <tmee@loc.gov>)
-->
  <xsl:output method="html" indent="yes"/>
  <xsl:strip-space elements="*" />
  <xsl:key name="namesByDisplayLabel" match="mods:name" use="@displayLabel" />
  <xsl:variable name="title" select="'Title'" />
  <xsl:variable name="name" select="'Name'" />
  <xsl:variable name="classification" select="'Classification'" />
  <xsl:variable name="subjectTopic" select="'Subject Topic'" />
  <xsl:variable name="subjectOccupation" select="'Subject Occupation'" />
  <xsl:variable name="subjectName" select="'Subject Name'" />
  <xsl:variable name="subjectGeographic" select="'Subject Geographic'" />
  <xsl:variable name="subjectHierGeographic" select="'Subject Hierarchical Geographic'" />
  <xsl:variable name="subjectCartographic" select="'Subject Cartographic'" />
  <xsl:variable name="subjectTemporal" select="'Subject Temporal'" />
  <xsl:variable name="subjectLocalname" select="'Subject Local Name'" />
  <xsl:variable name="abstract" select="'Abstract'" />
  <xsl:variable name="toc" select="'Table of Contents'" />
  <xsl:variable name="note" select="'Note'" />
  <xsl:variable name="dateIssued" select="'Date Issued'" />
  <xsl:variable name="dateCreated" select="'Date Created'" />
  <xsl:variable name="dateCaptured" select="'Date Digitized'" />
  <xsl:variable name="dateOther" select="'Date Other'" />
  <xsl:variable name="publisher" select="'Publisher'" />
  <xsl:variable name="place" select="'Place of Origin'" />
  <xsl:variable name="genre" select="'Genre'" />
  <xsl:variable name="typeOfResource" select="'Type of Resource'" />
  <xsl:variable name="extent" select="'Size'" />
  <xsl:variable name="form" select="'Form'" />
  <xsl:variable name="mediaType" select="'Media Type'" />
  <xsl:variable name="mimeType" select="'Mime Type'" />
  <xsl:variable name="identifier" select="'Identifier'" />
  <xsl:variable name="physicalLocation" select="'Physical Location'" />
  <xsl:variable name="shelfLocation" select="'Shelf Location'" />
  <xsl:variable name="url" select="'URL'" />
  <xsl:variable name="recommendedCitation" select="'Recommended Citation'" />
  <xsl:variable name="holdingSubLocation" select="'Holding Sublocation'" />
  <xsl:variable name="holdingShelfLocator" select="'Holding Shelf Locator'" />
  <xsl:variable name="electronicLocator" select="'Electronic Locator'" />
  <xsl:variable name="language" select="'Language'" />
  <xsl:variable name="relatedItem" select="'Related Item'" />
  <xsl:variable name="accessCondition" select="'Access Condition'" />

  <xsl:template match="/">
    <!-- <xsl:param name="title" />
	  <xsl:param name="name" />
	  <xsl:param name="classification" />
	  <xsl:param name="subjectTopic" />
	  <xsl:param name="subjectOccupation" />
	  <xsl:param name="subjectName" />
	  <xsl:param name="subjectGeographic" />
	  <xsl:param name="subjectHierGeographic" />
	  <xsl:param name="subjectCartographic" />
	  <xsl:param name="subjectTemporal" />
	  <xsl:param name="subjectLocalname" />
	  <xsl:param name="abstract" />
	  <xsl:param name="toc" />
	  <xsl:param name="note" />
	  <xsl:param name="dateIssued" />
	  <xsl:param name="dateCreated" />
	  <xsl:param name="dateCaptured" />
	  <xsl:param name="dateOther" />
	  <xsl:param name="publisher" />
	  <xsl:param name="genre" />
	  <xsl:param name="typeOfResource" />
	  <xsl:param name="extent" />
	  <xsl:param name="form" />
	  <xsl:param name="mediaType" />
	  <xsl:param name="mimeType" />
	  <xsl:param name="identifier" />
	  <xsl:param name="physicalLocation" />
	  <xsl:param name="shelfLocation" />
	  <xsl:param name="url" />
	  <xsl:param name="recommendedCitation" />
	  <xsl:param name="holdingSubLocation" />
	  <xsl:param name="holdingShelfLocator" />
	  <xsl:param name="electronicLocator" />
	  <xsl:param name="language" />
	  <xsl:param name="relatedItem" />
	  <xsl:param name="accessCondition" />-->
    <xsl:choose>
      <xsl:when test="//mods:modsCollection">
        <srw_dc:dcCollection xsi:schemaLocation="info:srw/schema/1/dc-schema http://www.loc.gov/standards/sru/dc-schema.xsd">
          <xsl:apply-templates/>
          <xsl:for-each select="mods:modsCollection/mods:mods">
            <srw_dc:dc xsi:schemaLocation="info:srw/schema/1/dc-schema http://www.loc.gov/standards/sru/dc-schema.xsd">

            </srw_dc:dc>
          </xsl:for-each>
        </srw_dc:dcCollection>
      </xsl:when>
      <xsl:otherwise>
        <xsl:for-each select="mods:mods">
          <!--  	<oai_dc:dc xsi:schemaLocation="http://www.openarchives.org/OAI/2.0/oai_dc/ http://www.openarchives.org/OAI/2.0/oai_dc.xsd"> -->
          <div class="metadataContainer">
            <!-- <div>
      	<th colspan="2">
        <h3 class="islandora-obj-details-metadata-title">Metadata <span
          class="islandora-obj-details-dsid">(MODS)</span></h3>
      	</th>
      </div> -->
            <xsl:apply-templates select="mods:titleInfo[not(@type)]" />
            <xsl:apply-templates select="mods:titleInfo[@type]" />
            <xsl:apply-templates select="*[not(self::mods:titleInfo)]" />
          </div>
          <!--  	</oai_dc:dc> -->
        </xsl:for-each>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="mods:titleInfo[normalize-space(.)]">
    <!-- <dc:title> -->
    <div class="metadataRow metaSetCore">
      <div class="metadataLabel">
        <xsl:choose>
          <xsl:when test="not(@displayLabel)">
            <xsl:value-of select="$title" />
          </xsl:when>
        </xsl:choose>
        <xsl:value-of select="@displayLabel" />
      </div>
      <div class="modsTitle metadataValue">
        <!--<xsl:if test="position()!=last()">-->
        <!--
            <xsl:value-of select="mods:nonSort"/>
        <xsl:if test="mods:nonSort">
        	<xsl:analyze-string select="." regex="[Ane]$">
    	        <xsl:matching-substring>
        	<xsl:text> </xsl:text>
        	</xsl:matching-substring></xsl:analyze-string>
        </xsl:if>
    -->
        <xsl:value-of select="mods:nonSort" />
        <xsl:if test="mods:nonSort">
          <xsl:text> </xsl:text>
        </xsl:if>
        <!--
  	<xsl:variable name="nonSortRegEx" select="'[Ane]$'"/>
          <xsl:value-of select="mods:nonSort"/>
          <xsl:if test="mods:nonSort">
              	<xsl:choose>
        	   	<xsl:when test="matches(mods:nonSort, $nonSortRegEx)">
                         <xsl:text> </xsl:text>
                  	</xsl:when>
                  	<xsl:otherwise/>
              	</xsl:choose>
          </xsl:if>
  	-->

        <xsl:value-of select="mods:title" />
        <xsl:if test="mods:subTitle">
          <xsl:if test="mods:title">: </xsl:if>
          <!--test for title element within this titleInfo-->
          <xsl:value-of select="mods:subTitle" />
        </xsl:if>
        <xsl:if test="mods:partNumber">
          <!--<xsl:text>. </xsl:text> -->
          <xsl:value-of select="mods:partNumber" />
        </xsl:if>
        <xsl:if test="mods:partName">
          <!--<xsl:text>. </xsl:text> -->
          <xsl:value-of select="mods:partName" />
        </xsl:if>
      </div>
    </div>
    <!-- </dc:title> -->
  </xsl:template>

  <xsl:template match="mods:part">
    <xsl:for-each select="mods:detail">
      <div class="metadataRow metaSetCore">
        <div class="metadataLabel">
          <xsl:choose>
            <xsl:when test="@type">
              <xsl:value-of select="concat(translate(substring(@type, 1, 1), 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'), substring(@type, 2))" />
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>Section Detail</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </div>
        <div class="metadataValue">
          <xsl:if test="mods:title[normalize-space()]">
            <xsl:if test="mods:caption">
              <xsl:value-of select="mods:caption" />
              <xsl:text> </xsl:text>
            </xsl:if>
            <xsl:value-of select="mods:title" />
          </xsl:if>
          <xsl:if test="mods:number[normalize-space()]">
            <xsl:if test="mods:caption">
              <xsl:value-of select="mods:caption" />
              <xsl:text> </xsl:text>
            </xsl:if>
            <xsl:value-of select="mods:number" />
          </xsl:if>
        </div>
      </div>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="mods:name[1][not(parent::mods:subject)]">
    <xsl:for-each select="/mods:mods/mods:name[not(mods:role/mods:roleTerm/text()='Facsimilist')][count(. | key('namesByDisplayLabel', @displayLabel)[1]) = 1]">
      <xsl:variable name="nameType" select="@type" />
      <div class="metadataRow metaSetCore">
        <div class="metadataLabel">
          <xsl:choose>
            <xsl:when test="not(@displayLabel)">
              <xsl:value-of select="$name" />
            </xsl:when>
          </xsl:choose>
          <xsl:value-of select="@displayLabel" />
        </div>
        <div class="metadataValue modsContributor">
          <xsl:choose>
            <xsl:when test="not(@displayLabel)">
              <xsl:for-each select="mods:namePart">
                <a>
                  <xsl:attribute name="href">
                    <xsl:choose>
                      <xsl:when test="$nameType">
                        <xsl:value-of select="'/islandora/search/mods_name_'" />
                        <xsl:value-of select="$nameType" />
                        <xsl:text>_namePart_mt%3A%2522</xsl:text>
                        <xsl:value-of select="." />
                        <xsl:text>%2522</xsl:text>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:value-of select="'/islandora/search/mods_name_namePart_mt%3A%2522'" />
                        <xsl:value-of select="." />
                        <xsl:value-of select="'%2522'" />
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:attribute>
                  <xsl:value-of select="." />
                </a>
                <br />
              </xsl:for-each>
            </xsl:when>
          </xsl:choose>
          <xsl:for-each select="key('namesByDisplayLabel', @displayLabel)">
            <a>
              <xsl:attribute name="href">
                <xsl:choose>
                  <xsl:when test="$nameType">
                    <xsl:value-of select="'/islandora/search/mods_name_'" />
                    <xsl:value-of select="$nameType" />
                    <xsl:text>_namePart_mt%3A%2522</xsl:text>
                    <xsl:value-of select="mods:namePart" />
                    <xsl:text>%2522</xsl:text>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="'/islandora/search/mods_name_namePart_mt%3A%2522'" />
                    <xsl:value-of select="mods:namePart" />
                    <xsl:value-of select="'%2522'" />
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:attribute>
              <xsl:value-of select="mods:namePart" />
            </a>
            <br />
          </xsl:for-each>
        </div>
      </div>
      <xsl:if test="mods:description|mods:affiliation">
        <!-- KNOWN ISSUE: This is only getting descripiton & affiliation for
    	the first occurrence of a name of a given display label -->
        <div class="metadataRow metaSetContent">
          <div class="metadataLabel">
            <xsl:text>Biographical Information</xsl:text>
          </div>
          <div class="metadataValue">
            <xsl:for-each select="mods:affiliation">
              <xsl:value-of select="." />
              <br />
            </xsl:for-each>
            <xsl:for-each select="mods:description">
              <xsl:value-of select="." />
              <br />
            </xsl:for-each>
          </div>
        </div>
        <br />
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="mods:classification">
    <div class="metadataRow metaSetAccess">
      <div class="metadataLabel">
        <xsl:value-of select="$classification" />
      </div>
      <div class="metadataValue">
        <xsl:value-of select="." />
      </div>
    </div>
  </xsl:template>

  <!--KNOWN ISSUE with all subjects: This approach only displays properly when
  all subelements under subject are identical, not with a mixed subject-->

  <xsl:template match="mods:subject[mods:topic][1]">
    <div class="metadataRow metaSetContent">
      <div class="metadataLabel">
        <xsl:if test="normalize-space(mods:topic)">
          <xsl:choose>
            <xsl:when test="not(@displayLabel)">
              <xsl:text>Subject</xsl:text>
            </xsl:when>
          </xsl:choose>
          <xsl:value-of select="@displayLabel" />
        </xsl:if>
      </div>
      <div class="metadataValue modsSubject">
        <a>
          <xsl:attribute name="href">
            <xsl:for-each select="mods:topic">
              <xsl:if test="position()=1">
                <xsl:value-of select="'/islandora/search/mods_subject_topic_ms%3A'" />
              </xsl:if>
              <xsl:text>%2522</xsl:text>
              <xsl:value-of select="." />
              <xsl:text>%2522</xsl:text>
            </xsl:for-each>
          </xsl:attribute>
          <xsl:for-each select="mods:topic">
            <xsl:value-of select="." />
            <xsl:if test="position()!=last()">--</xsl:if>
          </xsl:for-each>
        </a>
        <br />
        <xsl:for-each select="following-sibling::mods:subject[mods:topic]">
          <a>
            <xsl:attribute name="href">
              <xsl:for-each select="mods:topic">
                <xsl:if test="position()=1">
                  <xsl:value-of select="'/islandora/search/mods_subject_topic_ms%3A'" />
                </xsl:if>
                <xsl:text>%2522</xsl:text>
                <xsl:value-of select="." />
                <xsl:text>%2522</xsl:text>
              </xsl:for-each>
            </xsl:attribute>
            <xsl:for-each select="mods:topic">
              <xsl:value-of select="." />
              <xsl:if test="position()!=last()">--</xsl:if>
            </xsl:for-each>
          </a>
          <br />
        </xsl:for-each>
      </div>
    </div>
  </xsl:template>
  <xsl:template match="mods:subject[mods:geographic][1]">
    <div class="metadataRow metaSetContent">
      <div class="metadataLabel">
        <xsl:if test="normalize-space(mods:geographic)">
          <xsl:choose>
            <xsl:when test="not(@displayLabel)">
              <xsl:text>Location</xsl:text>
            </xsl:when>
          </xsl:choose>
          <xsl:value-of select="@displayLabel" />
        </xsl:if>
      </div>
      <div class="metadataValue modsSubject">

        <a>
          <xsl:attribute name="href">
            <xsl:for-each select="mods:geographic">
              <xsl:if test="position() = 1">
                <xsl:value-of select="'/islandora/search/mods_subject_geographic_ms%3A'" />
              </xsl:if>
              <xsl:text>%2522</xsl:text>
              <xsl:value-of select="." />
              <xsl:text>%2522</xsl:text>
            </xsl:for-each>
          </xsl:attribute>
          <xsl:for-each select="mods:geographic">
            <xsl:value-of select="." />
            <xsl:if test="position()!=last()">--</xsl:if>
          </xsl:for-each>
        </a>
        <br/>
        <xsl:for-each select="following-sibling::mods:subject[mods:geographic]">
          <a>
            <xsl:attribute name="href">
              <xsl:for-each select="mods:geographic">
                <xsl:if test="position() = 1">
                  <xsl:value-of select="'/islandora/search/mods_subject_geographic_ms%3A'" />
                </xsl:if>
                <xsl:text>%2522</xsl:text>
                <xsl:value-of select="." />
                <xsl:text>%2522</xsl:text>
              </xsl:for-each>
            </xsl:attribute>
            <xsl:for-each select="mods:geographic">
              <xsl:value-of select="." />
              <xsl:if test="position() != last()">--</xsl:if>
            </xsl:for-each>
          </a>
          <br/>
        </xsl:for-each>
      </div>
    </div>
  </xsl:template>
  <xsl:template match="mods:subject[mods:temporal][1]">
    <div class="metadataRow metaSetContent">
      <div class="metadataLabel">
        <xsl:if test="normalize-space(mods:temporal)">
          <xsl:choose>
            <xsl:when test="not(@displayLabel)">
              <xsl:text>Time Period</xsl:text>
            </xsl:when>
          </xsl:choose>
          <xsl:value-of select="@displayLabel" />
        </xsl:if>
      </div>
      <div class="metadataValue">
        <a>
          <xsl:attribute name="href">
            <xsl:for-each select="mods:temporal">
              <xsl:if test="position() = 1">
                <xsl:value-of select="'/islandora/search/mods_subject_temporal_ms%3A'" />
              </xsl:if>
              <xsl:text>%2522</xsl:text>
              <xsl:value-of select="." />
              <xsl:text>%2522</xsl:text>
            </xsl:for-each>
          </xsl:attribute>
          <xsl:for-each select="mods:temporal">
            <xsl:value-of select="." />
            <xsl:if test="position()!=last()">--</xsl:if>
          </xsl:for-each>
        </a>
        <br/>
        <xsl:for-each select="following-sibling::mods:subject[mods:temporal]">
          <a>
            <xsl:attribute name="href">
              <xsl:for-each select="mods:temporal">
                <xsl:if test="position() = 1">
                  <xsl:value-of select="'/islandora/search/mods_subject_temporal_ms%3A'" />
                </xsl:if>
                <xsl:text>%2522</xsl:text>
                <xsl:value-of select="." />
                <xsl:text>%2522</xsl:text>
              </xsl:for-each>
            </xsl:attribute>
            <xsl:for-each select="mods:temporal">
              <xsl:value-of select="." />
              <xsl:if test="position() != last()">--</xsl:if>
            </xsl:for-each>
          </a>
          <br/>
        </xsl:for-each>
      </div>
      <div class="metadataValue">
        <xsl:for-each select="following-sibling::mods:subject[mods:temporal]">
          <xsl:for-each select="mods:temporal">
            <a>
              <xsl:attribute name="href">
                <xsl:value-of select="'/islandora/search/mods_subject_temporal_ms%3A%2522'" />
                <xsl:value-of select="." />
                <xsl:value-of select="'%2522'" />
              </xsl:attribute>
              <xsl:value-of select="." />
            </a>
          </xsl:for-each>
          <br />
        </xsl:for-each>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="mods:subject[mods:occupation][1]">
    <div class="metadataRow metaSetContent">
      <div class="metadataLabel">
        <xsl:if test="normalize-space(mods:occupation)">
          <xsl:choose>
            <xsl:when test="not(@displayLabel)">
              <xsl:value-of select="$subjectOccupation" />
            </xsl:when>
          </xsl:choose>
          <xsl:value-of select="@displayLabel" />
        </xsl:if>
      </div>
      <div class="metadataValue modsSubject">
        <a>
          <xsl:attribute name="href">
            <xsl:for-each select="mods:occupation">
              <xsl:if test="position() = 1">
                <xsl:value-of select="'/islandora/search/mods_subject_occupation_ms%3A'" />
              </xsl:if>
              <xsl:text>%2522</xsl:text>
              <xsl:value-of select="." />
              <xsl:text>%2522</xsl:text>
            </xsl:for-each>
          </xsl:attribute>
          <xsl:for-each select="mods:occupation">
            <xsl:value-of select="." />
            <xsl:if test="position()!=last()">--</xsl:if>
          </xsl:for-each>
        </a>
        <br/>
        <xsl:for-each select="following-sibling::mods:subject[mods:occupation]">
          <a>
            <xsl:attribute name="href">
              <xsl:for-each select="mods:occupation">
                <xsl:if test="position() = 1">
                  <xsl:value-of select="'/islandora/search/mods_subject_occupation_ms%3A'" />
                </xsl:if>
                <xsl:text>%2522</xsl:text>
                <xsl:value-of select="." />
                <xsl:text>%2522</xsl:text>
              </xsl:for-each>
            </xsl:attribute>
            <xsl:for-each select="mods:occupation">
              <xsl:value-of select="." />
              <xsl:if test="position() != last()">--</xsl:if>
            </xsl:for-each>
          </a>
          <br/>
        </xsl:for-each>
      </div>
    </div>

  </xsl:template>

  <xsl:template match="mods:subject[mods:name][1]">
    <!--<xsl:if test="normalize-space(mods:name)">
  <xsl:for-each select="mods:name">
  	<div class="metadataRow"><div><xsl:value-of select="$subjectName"/></div><div>
    <xsl:call-template name="name"/>
  	</div></div>
  </xsl:for-each>
  </xsl:if>
  -->

    <div class="metadataRow metaSetContent">
      <div class="metadataLabel">
        <xsl:if test="normalize-space(mods:name/*)">
          <xsl:choose>
            <xsl:when test="not(@displayLabel)">
              <xsl:value-of select="$subjectName" />
            </xsl:when>
          </xsl:choose>
          <xsl:value-of select="@displayLabel" />
        </xsl:if>
      </div>

      <div class="modsSubject metadataValue">
        <xsl:for-each select="mods:name">
          <xsl:for-each select="/mods:mods/mods:subject/mods:name[count(. | key('namesByDisplayLabel', @displayLabel)[1]) = 1]">
            <xsl:variable name="nameType" select="@type" />
            <a>
              <xsl:attribute name="href">
                <xsl:for-each select="mods:namePart">
                  <xsl:choose>
                    <xsl:when test="$nameType">
                      <xsl:if test="position() = 1">
                        <xsl:value-of select="'/islandora/search/mods_subject_name_'" />

                        <xsl:value-of select="$nameType" />
                        <xsl:text>_namePart_mt%3A</xsl:text>
                      </xsl:if>
                      <xsl:text>%2522</xsl:text>
                      <xsl:value-of select="." />
                      <xsl:text>%2522</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:if test="position() = 1">
                        <xsl:value-of select="'/islandora/search/mods_subject_name_namePart_mt%3A'" />
                      </xsl:if>
                      <xsl:text>%2522</xsl:text>
                      <xsl:value-of select="." />
                      <xsl:text>%2522</xsl:text>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:for-each>
              </xsl:attribute>
              <xsl:for-each select="mods:namePart">
                <xsl:value-of select="." />
                <xsl:if test="position() != last()">--</xsl:if>
              </xsl:for-each>
            </a>
            <br/>
          </xsl:for-each>
          <xsl:for-each select="following-sibling::mods:subject[mods:name]">
            <xsl:variable name="nameType" select="@type" />
            <a>
              <xsl:attribute name="href">
                <xsl:for-each select="mods:namePart">
                  <xsl:choose>
                    <xsl:when test="$nameType">
                      <xsl:if test="position() = 1">
                        <xsl:value-of select="'/islandora/search/mods_subject_name_'" />

                        <xsl:value-of select="$nameType" />
                        <xsl:text>_namePart_mt%3A</xsl:text>
                      </xsl:if>
                      <xsl:text>%2522</xsl:text>
                      <xsl:value-of select="." />
                      <xsl:text>%2522</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:if test="position() = 1">
                        <xsl:value-of select="'/islandora/search/mods_subject_name_namePart_mt%3A'" />
                      </xsl:if>
                      <xsl:text>%2522</xsl:text>
                      <xsl:value-of select="." />
                      <xsl:text>%2522</xsl:text>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:for-each>
              </xsl:attribute>
              <xsl:for-each select="mods:namePart">
                <xsl:value-of select="." />
                <xsl:if test="position() != last()">--</xsl:if>
              </xsl:for-each>
            </a>
            <br/>
          </xsl:for-each>
        </xsl:for-each>
      </div>
      <!--  	<div>
    <xsl:choose>
    	<xsl:when test="not(@displayLabel)">
      <!-\-
    <xsl:for-each select="key('namesByDisplayLabel', @displayLabel)">

    	<a>
      <xsl:attribute name="href">
      	<xsl:choose>
        <xsl:when test="$nameType">
        	<xsl:value-of select="'/islandora/search/mods_name_'"/>
        	<xsl:value-of select="$nameType"/>
        	<xsl:text>_namePart_mt%3A%2522</xsl:text>
        	<xsl:value-of select="mods:namePart"/>
        	<xsl:text>%2522</xsl:text>
        </xsl:when>
        <xsl:otherwise>
        	<xsl:value-of select="'/islandora/search/mods_name_namePart_mt%3A%2522'"/>
        	<xsl:value-of select="mods:namePart"/>
        	<xsl:value-of select="'%2522'"/>
        </xsl:otherwise>
      	</xsl:choose>
      </xsl:attribute>
      <xsl:value-of select="mods:namePart"/>
    	</a>
    	<br />
    </xsl:for-each>-\->
    	</xsl:when>
    </xsl:choose>
  	</div>-->
    </div>
  </xsl:template>

  <xsl:template match="mods:subject[mods:hierarchicalGeographic | mods:cartographics ] ">
    <!-- 	<xsl:template match="mods:subject[mods:topic | mods:name | mods:occupation | mods:geographic | mods:hierarchicalGeographic | mods:cartographics | mods:temporal] "> -->

    <xsl:if test="normalize-space(mods:hierarchicalGeographic)">
      <xsl:for-each select="mods:hierarchicalGeographic">
        <div class="metadataRow metaSetContent">
          <div class="metadataLabel">
            <xsl:if test="normalize-space(mods:continent|mods:country|mods:provence|mods:region|mods:state|mods:territory|mods:county|mods:city|mods:island|mods:area|mods:citySection)">
              <xsl:choose>
                <xsl:when test="not(../@displayLabel)">
                  <!-- tests for parent's displayLabel -->
                  <xsl:value-of select="$subjectHierGeographic" />
                </xsl:when>
              </xsl:choose>
              <xsl:value-of select="../@displayLabel" />
            </xsl:if>
          </div>
          <div class="metadataValue">
            <xsl:for-each select="mods:continent|mods:country|mods:provence|mods:region|mods:state|mods:territory|mods:county|mods:city|mods:island|mods:area|mods:citySection">
              <xsl:value-of select="." />
              <xsl:if test="position()!=last()">--</xsl:if>
            </xsl:for-each>
          </div>
        </div>
      </xsl:for-each>
    </xsl:if>
    <xsl:if test="normalize-space(mods:cartographics)">
      <xsl:for-each select="mods:cartographics/*">
        <div class="metadataRow metaSetContent">
          <div class="metadataLabel">
            <xsl:value-of select="$subjectCartographic" />
          </div>
          <div class="metadataValue">
            <xsl:value-of select="." />
          </div>
        </div>
      </xsl:for-each>
    </xsl:if>
    <xsl:if test="normalize-space(mods:temporal)">
      <xsl:if test="mods:temporal">
        <div class="metadataRow metaSetContent">
          <div class="metadataLabel">
            <xsl:value-of select="$subjectTemporal" />
          </div>
          <div class="metadataValue">
            <xsl:for-each select="mods:temporal">
              <xsl:value-of select="." />
              <xsl:if test="position()!=last()">-</xsl:if>
            </xsl:for-each>
          </div>
        </div>
      </xsl:if>
    </xsl:if>
    <xsl:if test="*[1][local-name()='topic'] and *[local-name()!='topic']">
      <div class="metadataRow metaSetContent">
        <div class="metadataLabel">
          <xsl:value-of select="$subjectLocalname" />
        </div>
        <div class="metadataValue">
          <xsl:for-each select="*[local-name()!='cartographics' and local-name()!='geographicCode' and local-name()!='hierarchicalGeographic'] ">
            <xsl:value-of select="." />
            <xsl:if test="position()!=last()">--</xsl:if>
          </xsl:for-each>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="mods:abstract">
    <!-- <xsl:if test="mods:abstract =''"> -->
    <xsl:if test="normalize-space()">
      <xsl:variable name="urlchar" select="'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-#:%_+.~?&amp;/='" />
      <xsl:variable name="abstractUrl" select="substring-before(substring-after(., 'http'), substring(translate(substring-after(., 'http'), $urlchar, ''),1,1))" />
      <xsl:if test="normalize-space(.)">
        <div class="metadataRow metaSetContent">
          <div class="metadataLabel">
            <xsl:choose>
              <xsl:when test="not(@displayLabel)">
                <xsl:value-of select="$abstract" />
              </xsl:when>
            </xsl:choose>
            <xsl:value-of select="@displayLabel" />
          </div>
          <div class="metadataValue modsDesc">
            <xsl:choose>
              <xsl:when test="contains(., 'http')">
                <xsl:value-of select="substring-before(., 'http')" />
                <xsl:element name="a">
                  <xsl:attribute name="href">
                    <xsl:text>http</xsl:text>
                    <xsl:choose>
                      <xsl:when test="$abstractUrl = ''">
                        <xsl:value-of select="substring-after(., 'http')" />
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:value-of select="$abstractUrl" />
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:attribute>
                  <xsl:text>http</xsl:text>
                  <xsl:choose>
                    <xsl:when test="$abstractUrl = ''">
                      <xsl:value-of select="substring-after(., 'http')" />
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="$abstractUrl" />
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:element>
                <xsl:choose>
                  <xsl:when test="$abstractUrl = ''">
                    <!--do nothing-->
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="substring-after(., $abstractUrl)" />
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="." />
              </xsl:otherwise>
            </xsl:choose>
          </div>
        </div>
      </xsl:if>
    </xsl:if>
  </xsl:template>

  <xsl:template match="mods:tableOfContents">
    <!-- <xsl:if test="mods:tableOfContents =''"> -->
    <xsl:if test="normalize-space(.)">
      <div class="metadataRow metaSetContent">
        <div class="metadataLabel">
          <xsl:value-of select="toc" />
        </div>
        <div class="metadataValue">
          <xsl:value-of select="." />
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="mods:note">
    <xsl:variable name="urlchar" select="'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-#:%_+.~?&amp;/='" />
    <xsl:variable name="noteUrl" select="substring-before(substring-after(., 'http'), substring(translate(substring-after(., 'http'), $urlchar, ''),1,1))" />
    <xsl:if test="normalize-space(.)">
      <xsl:variable name="metaSetName">
        <xsl:choose>
          <xsl:when test="@type='ownership' or @type='preferred citation' or @type='citation/reference'">
            <xsl:value-of select="'metaSetAccess'" />
          </xsl:when>
          <xsl:when test="@type='thesis' or @type='statement of responsibility'">
            <xsl:value-of select="'metaSetCore'" />
          </xsl:when>
          <xsl:when test="@type='acquisition'">
            <xsl:value-of select="'metaSetAdmin'" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="'metaSetContent'" />
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <div class="metadataRow {$metaSetName}">
        <div class="metadataLabel">
          <xsl:choose>
            <xsl:when test="not(@displayLabel)">
              <xsl:value-of select="$note" />
            </xsl:when>
          </xsl:choose>
          <xsl:value-of select="@displayLabel" />
        </div>
        <div class="metadataValue">
          <xsl:choose>
            <xsl:when test="contains(., 'http')">
              <xsl:value-of select="substring-before(., 'http')" />
              <xsl:element name="a">
                <xsl:attribute name="href">
                  <xsl:text>http</xsl:text>
                  <xsl:choose>
                    <xsl:when test="$noteUrl = ''">
                      <xsl:value-of select="substring-after(., 'http')" />
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="$noteUrl" />
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:attribute>
                <xsl:text>http</xsl:text>
                <xsl:choose>
                  <xsl:when test="$noteUrl = ''">
                    <xsl:value-of select="substring-after(., 'http')" />
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="$noteUrl" />
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:element>
              <xsl:choose>
                <xsl:when test="$noteUrl = ''">
                  <!--do nothing-->
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="substring-after(., $noteUrl)" />
                </xsl:otherwise>
              </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="." />
            </xsl:otherwise>
          </xsl:choose>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <!-- date stuff -->
  <!--
	<xsl:template match="mods:originInfo">
	<xsl:for-each select="mods:dateIssued">
	<div class="metadataRow"><div><xsl:value-of select="$dateCreated"/></div><div>aoeuaoeu<xsl:value-of select="."/></div></div>
	</xsl:for-each>
	</xsl:template>
-->
  <xsl:template match="mods:originInfo">
    <xsl:if test="mods:edition">
      <div class="metadataRow metaSetCore">
        <div class="metadataLabel">
          <xsl:text>Edition</xsl:text>
        </div>
        <div class="metadataValue">
          <xsl:value-of select="mods:edition" />
        </div>
      </div>
    </xsl:if>
    <xsl:if test="mods:dateCreated">
      <div class="metadataRow metaSetCore">
        <div class="metadataLabel">
          <xsl:value-of select="$dateCreated" />
        </div>
        <div class="metadataValue">
          <xsl:value-of select="mods:dateCreated" />
          <xsl:if test="mods:dateCreated/@qualifier != ''">
            <xsl:text> (</xsl:text>
            <xsl:value-of select="mods:dateCreated/@qualifier" />
            <xsl:text>)</xsl:text>
          </xsl:if>
          <xsl:if test="mods:dateCreated[@point='end']">
            <xsl:text> - </xsl:text>
            <xsl:value-of select="mods:dateCreated[@point='end']" />
            <xsl:if test="mods:dateCreated/@qualifier != ''">
              <xsl:text> (</xsl:text>
              <xsl:value-of select="mods:dateCreated/@qualifier" />
              <xsl:text>)</xsl:text>
            </xsl:if>
          </xsl:if>
        </div>
      </div>
    </xsl:if>
    <xsl:if test="mods:dateCaptured">
      <div class="metadataRow metaSetAdmin">
        <div class="metadataLabel">
          <xsl:choose>
            <xsl:when test="@displayLabel">
              <xsl:value-of select="@displayLabel" />
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$dateCaptured" />
            </xsl:otherwise>
          </xsl:choose>
        </div>
        <div class="metadataValue">
          <xsl:value-of select="mods:dateCaptured" />
          <xsl:if test="mods:dateCaptured/@qualifier != ''">
            <xsl:text> (</xsl:text>
            <xsl:value-of select="mods:dateCaptured/@qualifier" />
            <xsl:text>)</xsl:text>
          </xsl:if>
          <xsl:if test="mods:dateCaptured[@point = 'end']">
            <xsl:text> - </xsl:text>
            <xsl:value-of select="mods:dateCaptured[@point = 'end']" />
            <xsl:if test="mods:dateCaptured/@qualifier != ''">
              <xsl:text> (</xsl:text>
              <xsl:value-of select="mods:dateCaptured/@qualifier" />
              <xsl:text>)</xsl:text>
            </xsl:if>
          </xsl:if>
        </div>
      </div>
    </xsl:if>
    <xsl:if test="mods:dateIssued">
      <div class="metadataRow metaSetCore">
        <div class="metadataLabel">
          <xsl:text>Date Published</xsl:text>
        </div>
        <div class="metadataValue">
          <xsl:value-of select="mods:dateIssued" />
          <xsl:if test="mods:dateIssued/@qualifier != ''">
            <xsl:text> (</xsl:text>
            <xsl:value-of select="mods:dateIssued/@qualifier" />
            <xsl:text>)</xsl:text>
          </xsl:if>
          <xsl:if test="mods:dateIssued[@point='end']">
            <xsl:text> - </xsl:text>
            <xsl:value-of select="mods:dateIssued[@point='end']" />
            <xsl:if test="mods:dateIssued/@qualifier != ''">
              <xsl:text> (</xsl:text>
              <xsl:value-of select="mods:dateIssued/@qualifier" />
              <xsl:text>)</xsl:text>
            </xsl:if>
          </xsl:if>
        </div>
      </div>
    </xsl:if>
    <xsl:if test="mods:publisher">
      <div class="metadataRow metaSetCore">
        <div class="metadataLabel">
          <xsl:text>Publisher</xsl:text>
        </div>
        <div class="metadataValue">
          <xsl:value-of select="mods:publisher" />
        </div>
      </div>
    </xsl:if>
    <xsl:for-each select="mods:place">
      <div class="metadataRow metaSetCore">
        <div class="metadataLabel">
          <xsl:choose>
            <xsl:when test="parent::mods:originInfo[@displayLabel]">
              <xsl:value-of select="parent::mods:originInfo/@displayLabel" />
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$place" />
            </xsl:otherwise>
          </xsl:choose>
        </div>
        <div class="metadataValue">
          <xsl:value-of select="mods:placeTerm" />
        </div>
      </div>
    </xsl:for-each>
  </xsl:template>
  <!--
<xsl:template match="mods:originInfo">
       <xsl:if test="mods:dateIssued[contains(@point,'start')] and mods:dateIssued[contains(@point,'end')] and not(mods:dateIssued[@qualifier])"><div class="metadataRow"><div><xsl:value-of select="$dateIssued"/></div><div><xsl:value-of select="mods:dateIssued[contains(@point,'start')]"/>-<xsl:value-of select="mods:dateIssued[contains(@point,'end')]"/></div></div></xsl:if>
       <xsl:if test="mods:dateIssued[contains(@point,'start')] and mods:dateIssued[contains(@point,'end')] and mods:dateIssued[@qualifier]"><div class="metadataRow"><div><xsl:value-of select="$dateIssued"/></div><div>Approximately <xsl:value-of select="mods:dateIssued[contains(@point,'start')]"/>-<xsl:value-of select="mods:dateIssued[contains(@point,'end')]"/></div></div></xsl:if>
       <xsl:if test="mods:dateIssued[contains(@keydate,'yes')] and not(mods:dateIssued[@point]) and not(mods:dateIssued[@qualifier])"><div class="metadataRow"><div><xsl:value-of select="$dateIssued"/></div><div><xsl:value-of select="mods:dateIssued"/></div></div></xsl:if>
       <xsl:if test="mods:dateIssued[contains(@keydate,'yes')] and not(mods:dateIssued[@point]) and mods:dateIssued[@qualifier]"><div class="metadataRow"><div><xsl:value-of select="$dateIssued"/></div><div>Approximately <xsl:value-of select="mods:dateIssued"/></div></div></xsl:if>
       <xsl:if test="mods:dateCreated"><div class="metadataRow"><div><xsl:value-of select="$dateCreated"/></div><div><xsl:value-of select="mods:dateCreated"/></div></div></xsl:if>
       <xsl:if test="mods:dateCaptured"><div class="metadataRow"><div><xsl:value-of select="$dateCaptured"/></div><div><xsl:value-of select="mods:dateCaptured"/></div></div></xsl:if>
       <xsl:if test="mods:dateIssued"><div class="metadataRow"><div><xsl:value-of select="$dateIssued"/></div><div><xsl:value-of select="mods:dateIssued"/></div></div></xsl:if>
   </xsl:template>
   -->
  <!--
	<xsl:template match="mods:originInfo">
  <div class="metadataRow"><div><xsl:copy-of select="name(.)"/></div><div><xsl:value-of select="."/></div></div>
  <xsl:if test="mods:dateIssued"><div class="metadataRow"><div><xsl:value-of select="$dateIssued"/></div>
	<div><xsl:analyze-string select="." regex="([0-9]{8})">
  <xsl:matching-substring>
  <xsl:text>"match"</xsl:text></xsl:matching-substring>
	    </xsl:analyze-string>
  	<xsl:value-of select="."/></div></div></xsl:if>

  <xsl:if test="mods:dateCreated"><div class="metadataRow"><div><xsl:value-of select="$dateCreated"/></div>
	<div>
  <xsl:value-of select="."/></div></div></xsl:if>

  <xsl:if test="mods:dateCaptured"><div class="metadataRow"><div><xsl:value-of select="$dateCaptured"/></div>
	<div>
  <xsl:value-of select="."/></div></div></xsl:if>
	<div class="metadataRow"><div><xsl:copy-of select="name(.)"/></div><div><xsl:value-of select="."/></div></div>
	</xsl:template>
-->
  <!--
	<xsl:template match="mods:originInfo">
  <xsl:apply-templates select="*[@point='start']"/>
  <xsl:for-each select="mods:dateIssued[@point!='start' and @point!='end']">
    <div class="metadataRow"><div><xsl:value-of select="$dateIssued"/></div><div>
    <xsl:value-of select="."/>
    </div></div>
  </xsl:for-each>
  <xsl:for-each select="mods:dateCreated[@point!='start' and @point!='end']">
    <div class="metadataRow"><div><xsl:value-of select="$dateCreated"/></div><div>
    <xsl:value-of select="."/>
  	</div></div>
  </xsl:for-each>
  <xsl:for-each select="mods:dateCaptured[@point!='start' and @point!='end']">
    <div class="metadataRow"><div><xsl:value-of select="$dateCaptured"/></div><div>
    <xsl:value-of select="."/>
  	</div></div>
  </xsl:for-each>
  <xsl:for-each select="mods:dateOther[@point!='start' and @point!='end']">
    <div class="metadataRow"><div><xsl:value-of select="$dateOther"/></div><div>
    <xsl:value-of select="."/>
  	</div></div>
  </xsl:for-each>
  <xsl:for-each select="mods:publisher">
    <xsl:if test="normalize-space(mods:publisher)">
    <div class="metadataRow"><div><xsl:value-of select="$publisher"/></div><div>
    <xsl:value-of select="."/>
    </div></div>
    </xsl:if>
  </xsl:for-each>

	</xsl:template>
-->
  <!--
	<xsl:template match="mods:dateIssued | mods:dateCreated | mods:dateCaptured">
  <dc:date>
  	<xsl:choose>
    <xsl:when test="@point='start'">
    	<xsl:value-of select="."/>
    	<xsl:text> - </xsl:text>
    </xsl:when>
    <xsl:when test="@point='end'">
    	<xsl:value-of select="."/>
    </xsl:when>
    <xsl:otherwise>
    	<xsl:value-of select="."/>
    </xsl:otherwise>
  	</xsl:choose>
  </dc:date>
	</xsl:template>
-->

  <xsl:template match="mods:genre">
    <xsl:if test="normalize-space()">
      <div class="metadataRow metaSetContent">
        <div class="metadataLabel">
          <xsl:value-of select="$genre" />
        </div>
        <div class="metadataValue">
          <xsl:value-of select="." />
        </div>
      </div>
    </xsl:if>
    <!--
  <xsl:choose>
  	<xsl:when test="@authority='dct'">
    <dc:type>
    	<xsl:value-of select="."/>
    </dc:type>
    <xsl:for-each select="mods:typeOfResource">
    	<dc:type>
      <xsl:value-of select="."/>
    	</dc:type>
    </xsl:for-each>
  	</xsl:when>
  	<xsl:otherwise>
    <dc:type>
    	<xsl:value-of select="."/>
    </dc:type>
  	</xsl:otherwise>
  </xsl:choose>
  -->
  </xsl:template>

  <xsl:template match="mods:typeOfResource">
    <div class="metadataRow metaSetCarrier">
      <div class="metadataLabel">
        <xsl:value-of select="$typeOfResource" />
      </div>
      <div class="metadataValue">
        <xsl:value-of select="." />
      </div>
    </div>
    <!--
  <xsl:if test="@collection='yes'">
  	<dc:type>Collection</dc:type>
  </xsl:if>
  <xsl:if test=". ='software' and ../mods:genre='database'">
  	<dc:type>DataSet</dc:type>
  </xsl:if>
  <xsl:if test=".='software' and ../mods:genre='online system or service'">
  	<dc:type>Service</dc:type>
  </xsl:if>
  <xsl:if test=".='software'">
  	<dc:type>Software</dc:type>
  </xsl:if>
  <xsl:if test=".='cartographic material'">
  	<dc:type>Image</dc:type>
  </xsl:if>
  <xsl:if test=".='multimedia'">
  	<dc:type>InteractiveResource</dc:type>
  </xsl:if>
  <xsl:if test=".='moving image'">
  	<dc:type>MovingImage</dc:type>
  </xsl:if>
  <xsl:if test=".='three-dimensional object'">
  	<dc:type>PhysicalObject</dc:type>
  </xsl:if>
  <xsl:if test="starts-with(.,'sound recording')">
  	<dc:type>Sound</dc:type>
  </xsl:if>
  <xsl:if test=".='still image'">
  	<dc:type>StillImage</dc:type>
  </xsl:if>
  <xsl:if test=". ='text'">
  	<dc:type>Text</dc:type>
  </xsl:if>
  <xsl:if test=".='notated music'">
  	<dc:type>Text</dc:type>
  </xsl:if>
-->
  </xsl:template>

  <xsl:template match="mods:physicalDescription">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="mods:extent">
    <xsl:if test="normalize-space(.)">
      <div class="metadataRow metaSetCarrier">
        <div class="metadataLabel">
          <xsl:value-of select="$extent" />
        </div>
        <div class="metadataValue">
          <xsl:value-of select="." />
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="mods:internetMediaType">
    <xsl:if test="normalize-space(.)">
      <div class="metadataRow metaSetCarrier">
        <div class="metadataLabel">
          <xsl:value-of select="$mediaType" />
        </div>
        <div class="metadataValue">
          <xsl:value-of select="." />
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="mods:form">
    <xsl:if test="normalize-space(.)">
      <div class="metadataRow metaSetCarrier">
        <div class="metadataLabel">
          <xsl:choose>
            <xsl:when test="parent::mods:physicalDescription[@displayLabel]">
              <xsl:value-of select="parent::mods:physicalDescription/@displayLabel" />
            </xsl:when>
            <xsl:when test="@type = 'material'">
              <xsl:value-of select="'Material'" />
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$form" />
            </xsl:otherwise>
          </xsl:choose>
        </div>
        <div class="metadataValue">
          <xsl:value-of select="." />
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="mods:note[parent::mods:physicalDescription]">
    <xsl:if test="normalize-space(.)">
      <div class="metadataRow metaSetCarrier">
        <div class="metadataLabel">
          <xsl:choose>
            <xsl:when test="@displayLabel">
              <xsl:value-of select="@displayLabel" />
            </xsl:when>
            <xsl:when test="@type">
              <xsl:value-of select="concat(translate(substring(@type, 1, 1), 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'), substring(@type, 2))" />
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>Physical Description Note</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </div>
        <div class="metadataValue">
          <xsl:value-of select="." />
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="mods:mimeType">
    <xsl:if test="normalize-space(.)">
      <div class="metadataRow metaSetCarrier">
        <div class="metadataLabel">
          <xsl:value-of select="$mimeType" />
        </div>
        <div class="metadataValue">
          <xsl:value-of select="." />
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <!--	<xsl:template match="mods:identifier">
	  <div class="metadataRow">
	  	<div>
	    <xsl:value-of select="$identifier"/>
	  	</div>
	  	<div>
	      <xsl:value-of select="."/> Identify yourself
	  	</div>
	  </div>-->
  <!--
  <xsl:variable name="type" select="translate(@type,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')"/>
  <xsl:choose>
  	<xsl:when test="contains ('isbn issn uri doi lccn uri', $type)">
    <dc:identifier>
    	<xsl:value-of select="$type"/>: <xsl:value-of select="."/>
    </dc:identifier>
  	</xsl:when>
  	<xsl:otherwise>
    <dc:identifier>
    	<xsl:value-of select="."/>
    </dc:identifier>
  	</xsl:otherwise>
  </xsl:choose>
  -->
  <!--</xsl:template>-->

  <!-- will's template for physloc -->
  <xsl:template match="mods:location">
    <xsl:for-each select="mods:physicalLocation[not(@displayLabel='OCLC Member Symbol')]">
      <div class="metadataRow metaSetAccess">
        <div class="metadataLabel">
          <xsl:choose>
            <xsl:when test="@displayLabel">
              <xsl:value-of select="@displayLabel" />
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$physicalLocation" />
            </xsl:otherwise>
          </xsl:choose>
        </div>
        <div class="metadataValue">
          <xsl:choose>
            <xsl:when test="@displayLabel = 'Physical Location'">
              <xsl:choose>
                <xsl:when test="@xlink:href">
                  <xsl:element name="a">
                    <xsl:attribute name="href">
                      <xsl:value-of select="@xlink:href" />
                    </xsl:attribute>
                    <xsl:value-of select="." />
                  </xsl:element>
                </xsl:when>
                <xsl:when test="parent::mods:location/mods:url[@displayLabel = 'Institution Web Site']">
                  <xsl:element name="a">
                    <xsl:attribute name="href">
                      <xsl:value-of select="parent::mods:location/mods:url[@displayLabel = 'Institution Web Site']" />
                    </xsl:attribute>
                    <xsl:value-of select="." />
                  </xsl:element>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="." />
                </xsl:otherwise>
              </xsl:choose>
              <xsl:if test="normalize-space(parent::mods:location/mods:holdingSimple/mods:copyInformation/mods:subLocation)">
                <xsl:for-each select="parent::mods:location/mods:holdingSimple/mods:copyInformation/mods:subLocation">
                  <br />
                  <xsl:value-of select="." />
                </xsl:for-each>
              </xsl:if>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="." />
            </xsl:otherwise>
          </xsl:choose>
        </div>
      </div>
    </xsl:for-each>

    <xsl:if test="normalize-space(mods:shelfLocator)">
      <div class="metadataRow metaSetAccess">
        <div class="metadataLabel">
          <xsl:value-of select="$shelfLocation" />
        </div>
        <div class="metadataValue">
          <xsl:for-each select="mods:shelfLocator">
            <xsl:value-of select="." />
          </xsl:for-each>
        </div>
      </div>
    </xsl:if>
    <!--  <xsl:if test="normalize-space(mods:url)">
	    <div class="metadataRow"><div><xsl:value-of select="$url"/></div><div>
  <xsl:for-each select="mods:url">
    <xsl:value-of select="."/>
  </xsl:for-each>
	    </div></div>
	  </xsl:if> -->
    <xsl:if test="normalize-space(mods:recommendedCitation)">
      <div class="metadataRow metaSetAccess">
        <div class="metadataLabel">
          <xsl:value-of select="$recommendedCitation" />
        </div>
        <div class="metadataValue">
          <xsl:for-each select="mods:recommendedCitation">
            <xsl:value-of select="." />
          </xsl:for-each>
        </div>
      </div>
    </xsl:if>
    <xsl:if test="normalize-space(mods:holdingSimple/mods:copyInformation/mods:shelfLocator)">
      <div class="metadataRow metaSetAccess">
        <div class="metadataLabel">
          <xsl:value-of select="$shelfLocation" />
        </div>
        <div class="metadataValue">
          <xsl:for-each select="mods:holdingSimple/mods:copyInformation/mods:shelfLocator">
            <xsl:value-of select="." />
          </xsl:for-each>
        </div>
      </div>
    </xsl:if>
    <xsl:for-each select="mods:url[not(@displayLabel = 'Institution Web Site')]">
      <div class="metadataRow metaSetAccess">
        <div class="metadataLabel">
          <xsl:choose>
            <xsl:when test="@displayLabel">
              <xsl:value-of select="@displayLabel" />
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$url" />
            </xsl:otherwise>
          </xsl:choose>
        </div>
        <div class="metadataValue">
          <xsl:element name="a">
            <xsl:attribute name="href">
              <xsl:value-of select="." />
            </xsl:attribute>
            <xsl:value-of select="." />
          </xsl:element>
        </div>
      </div>
    </xsl:for-each>
    <xsl:if test="normalize-space(mods:holdingSimple/mods:copyInformation/mods:electronicLocator)">
      <div class="metadataRow metaSetAccess">
        <div class="metadataLabel">
          <xsl:value-of select="$electronicLocator" />
        </div>
        <div class="metadataValue">
          <xsl:for-each select="mods:holdingSimple/mods:copyInformation/mods:electronicLocator">
            <xsl:value-of select="." />
          </xsl:for-each>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <!--	<xsl:template match="mods:location/mods:holdingSimple/mods:copyInformation">
	  <dc:identifier>
	    <xsl:for-each select="mods:sublocation | mods:shelfLocator | mods:electronicLocator">
	      <xsl:value-of select="."/>
	      <xsl:if test="position()!=last()"></xsl:if>
	    </xsl:for-each>
	  </dc:identifier>
	</xsl:template>-->

  <xsl:template match="mods:language">
    <div class="metadataRow metaSetAccess">
      <xsl:choose>
        <xsl:when test="mods:languageTerm/@type='text'">
          <div class="metadataLabel">
            <xsl:text>Language</xsl:text>
          </div>
          <div class="metadataValue">
            <xsl:for-each select="mods:languageTerm[@type='text']">
              <xsl:value-of select="." />
              <xsl:if test="position()!=last()">, </xsl:if>
            </xsl:for-each>
          </div>
        </xsl:when>
        <xsl:otherwise>
          <div class="metadataLabel">
            <xsl:text>Language Code</xsl:text>
          </div>
          <div class="metadataValue">
            <xsl:for-each select="mods:languageTerm[@type='code']">
              <xsl:value-of select="." />
              <xsl:if test="position()!=last()">, </xsl:if>
            </xsl:for-each>
          </div>
        </xsl:otherwise>
      </xsl:choose>
    </div>
  </xsl:template>

  <!-- <start will's own loop>-->
  <xsl:template match="mods:identifier[not(@displayLabel='Migrated From')]">
    <div class="metadataRow metaSetCore">
      <div class="metadataLabel">
        <xsl:value-of select="@displayLabel" />
      </div>
      <div class="metadataValue">
        <xsl:value-of select="." />
      </div>
    </div>
  </xsl:template>

  <xsl:template match="mods:relatedItem[mods:titleInfo]">
    <xsl:variable name="metaSetName">
      <xsl:choose>
        <xsl:when test="@type='host'">
          <xsl:value-of select="'metaSetCollection'" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="'metaSetAccess'" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:for-each select="mods:titleInfo[not(@displayLabel='Parent Item Title')]">
      <div class="metadataRow {$metaSetName}">
        <div class="metadataLabel">
          <xsl:value-of select="@displayLabel" />
        </div>
        <div class="metadataValue">
          <xsl:value-of select="mods:title | mods:partNumber | mods:partName" />
        </div>
      </div>
    </xsl:for-each>
    <xsl:for-each select="mods:location/mods:url[not(@displayLabel='Relation')]">
      <div class="metadataRow {$metaSetName}">
        <div class="metadataLabel">
          <xsl:value-of select="@displayLabel" />
        </div>
        <div class="metadataValue">
          <xsl:element name="a">
            <xsl:attribute name="href">
              <xsl:value-of select="." />
            </xsl:attribute>
            <xsl:value-of select="." />
          </xsl:element>
        </div>
      </div>
    </xsl:for-each>
    <xsl:for-each select="mods:physicalDescription[mods:note]">
      <div class="metadataRow metaSetCarrier">
        <div class="metadataLabel">
          <xsl:choose>
            <xsl:when test="mods:note/@type='medium'">
              <xsl:text>Medium</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="mods:note/@type" />
            </xsl:otherwise>
          </xsl:choose>
        </div>
        <div class="metadataValue">
          <xsl:value-of select="mods:note" />
        </div>
      </div>
    </xsl:for-each>
    <xsl:for-each select="mods:physicalDescription[mods:extent]">
      <div class="metadataRow metaSetCarrier">
        <div class="metadataLabel">
          <xsl:text>Extent</xsl:text>
        </div>
        <div class="metadataValue">
          <xsl:value-of select="mods:extent" />
        </div>
      </div>
    </xsl:for-each>
    <xsl:for-each select="mods:part">
      <div class="metadataRow {$metaSetName}">
        <div class="metadataLabel">
          <xsl:choose>
            <xsl:when test="@displayLabel">
              <xsl:value-of select="@displayLabel" />
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>Part of</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </div>
        <div class="metadataValue">
          <xsl:if test="mods:detail/mods:title">
            <xsl:value-of select="mods:detail/mods:title" />
          </xsl:if>
          <xsl:if test="mods:detail/mods:number">
            <xsl:value-of select="mods:detail/mods:number" />
          </xsl:if>
          <xsl:if test="mods:extent">
            <xsl:value-of select="mods:extent/*" />
          </xsl:if>
        </div>
      </div>
    </xsl:for-each>
    <xsl:for-each select="mods:note[@type='content']">
      <div class="metadataRow {$metaSetName}">
        <div class="metadataLabel">
          <xsl:text>Host Content Note</xsl:text>
        </div>
        <div class="metadataValue">
          <xsl:value-of select="." />
        </div>
      </div>
    </xsl:for-each>
    <xsl:for-each select="mods:identifier">
      <div class="metadataRow {$metaSetName}">
        <div class="metadataLabel">
          <xsl:choose>
            <xsl:when test="@displayLabel">
              <xsl:value-of select="@displayLabel" />
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>Host Identifier</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </div>
        <div class="metadataValue">
          <xsl:value-of select="." />
        </div>
      </div>
    </xsl:for-each>
    <xsl:for-each select="mods:abstract">
      <div class="metadataRow metaSetContent">
        <div class="metadataLabel">
          <xsl:choose>
            <xsl:when test="@displayLabel">
              <xsl:value-of select="@displayLabel" />
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>Host Abstract</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </div>
        <div class="metadataValue">
          <xsl:value-of select="." />
        </div>
      </div>
    </xsl:for-each>
  </xsl:template>
  <!--	<xsl:template match="mods:relatedItem[mods:part]">
  <xsl:for-each select="mods:part">
  	<div class="metadataRow">
    <div>
    	<xsl:text>Part of</xsl:text>
    </div>
    <div>
    	<xsl:value-of select="mods:detail/mods:title"/>
    </div>
  	</div>
  </xsl:for-each>
	</xsl:template>
	<xsl:template match="mods:relatedItem[mods:physicalDescription]">
  <xsl:for-each select="mods:physicalDescription">
  	<div class="metadataRow">
    <div>
    	<xsl:choose>
      <xsl:when test="mods:note/@type='medium'">
      	<xsl:text>Medium</xsl:text>
      </xsl:when>
      <xsl:otherwise>
      	<xsl:value-of select="mods:note/@type"/>
      </xsl:otherwise>
    	</xsl:choose>
    	</div>
    <div>
    	<xsl:value-of select="mods:note"/>
    </div>
  	</div>
  </xsl:for-each>
	</xsl:template>-->

  <!--<xsl:template match="mods:relatedItem[mods:titleInfo | mods:identifier | mods:location]">
<!-\-	<xsl:template match="mods:relatedItem[mods:titleInfo | mods:name | mods:identifier | mods:location]"> -\->
  <xsl:choose>
  	<xsl:when test="@type='original'">
  	  <div class="metadataRow"><div><xsl:value-of select="mods:titleInfo/@displayLabel | identifier/@displayLabel  | mods:location/mods:url/@displayLabel"/></div><div>
    	<xsl:for-each
      select="mods:titleInfo/mods:title | mods:identifier | mods:location/mods:recommendedCitation">
      <xsl:if test="normalize-space(.)!= ''">
      	<xsl:value-of select="."/>
      	<xsl:if test="position()!=last()">-\-</xsl:if>
      </xsl:if>
    	</xsl:for-each>
  	  </div></div>
  	</xsl:when>
  	<xsl:when test="mods:titleInfo/@type='alternative'">
    <div class="metadataRow">
    	<div>
      <xsl:value-of select="mods:titleInfo[@type='alternative']/@displayLabel | identifier/@displayLabel  | mods:location/mods:url/@displayLabel"/>
    	</div>
    	<div>
      <xsl:for-each select="mods:titleInfo[@type='alternative']/mods:title | mods:identifier | mods:location/mods:recommendedCitation">
      	<xsl:if test="normalize-space(.)!= ''">
        <xsl:value-of select="."/> and alternative
        <xsl:if test="position()!=last()">-\-</xsl:if>
      	</xsl:if>
      </xsl:for-each>
    	</div>
    </div>
  	</xsl:when>
  	<xsl:when test="@type='series'"/>
  	<xsl:otherwise>
  	  <div class="metadataRow">
  	  	<div>
  	    <xsl:value-of select="mods:titleInfo/@displayLabel | mods:identifier/@displayLabel  | mods:location/mods:url/@displayLabel"/>
  	  	</div>
  	  	<div>
    	<xsl:for-each
      select="mods:titleInfo/mods:title | mods:identifier | mods:location/mods:recommendedCitation">
      <xsl:if test="normalize-space(.)!= ''">
      	<xsl:value-of select="."/> and otherwise
      	<xsl:if test="position()!=last()">-\-</xsl:if>
      </xsl:if>
    	</xsl:for-each>
  	  	</div>
  	  </div>
  	</xsl:otherwise>
  </xsl:choose>
	</xsl:template>-->

  <xsl:template match="mods:accessCondition">
    <xsl:variable name="urlchar" select="'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-#:%_+.~?&amp;/='" />
    <xsl:variable name="accessUrl" select="substring-before(substring-after(., 'http'), substring(translate(substring-after(., 'http'), $urlchar, ''),1,1))" />
    <xsl:if test="normalize-space(.)">
      <div class="metadataRow metaSetAccess">
        <div class="metadataLabel">
          <xsl:choose>
            <xsl:when test="not(@displayLabel)">
              <xsl:value-of select="$accessCondition" />
            </xsl:when>
          </xsl:choose>
          <xsl:value-of select="@displayLabel" />
        </div>
        <div class="metadataValue">
          <xsl:choose>
            <xsl:when test="@xlink:href">
              <xsl:element name="a">
                <xsl:attribute name="href">
                  <xsl:value-of select="@xlink:href" />
                </xsl:attribute>
                <xsl:value-of select="." />
              </xsl:element>
            </xsl:when>
            <xsl:when test="contains(., 'http')">
              <xsl:value-of select="substring-before(., 'http')" />
              <xsl:element name="a">
                <xsl:attribute name="href">
                  <xsl:text>http</xsl:text>
                  <xsl:choose>
                    <xsl:when test="$accessUrl = ''">
                      <xsl:value-of select="substring-after(., 'http')" />
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="$accessUrl" />
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:attribute>
                <xsl:text>http</xsl:text>

                <xsl:choose>
                  <xsl:when test="$accessUrl = ''">
                    <xsl:value-of select="substring-after(., 'http')" />
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="$accessUrl" />
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:element>
              <xsl:choose>
                <xsl:when test="$accessUrl = ''">
                  <!--do nothing-->
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="substring-after(., $accessUrl)" />
                </xsl:otherwise>
              </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="." />
            </xsl:otherwise>
          </xsl:choose>
        </div>
      </div>
    </xsl:if>
  </xsl:template>
  <xsl:template match="mods:identifier[@displayLabel='Object File Name']">
    <div class="metadataRow metaSetCore">
      <div class="metadataLabel">Object File Name</div>
      <div class="metadataValue">
        <xsl:value-of select="." />
      </div>
    </div>
  </xsl:template>

  <xsl:template match="mods:extension">
    <xsl:if test="normalize-space(mods:hardwareSoftware)">
      <div class="metadataRow metaSetAdmin">
        <div class="metadataLabel">
          <xsl:text>Digital Reproduction Information</xsl:text>
        </div>
        <div class="metadataValue">
          <xsl:value-of select="mods:hardwareSoftware" />
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template name="name">
    <xsl:value-of select="mods:namePart" />
    <!--
  <xsl:variable name="name-value">
  	<xsl:for-each select="mods:namePart[not(@type)]">
    <xsl:value-of select="."/>
    <xsl:text> </xsl:text>
  	</xsl:for-each>
  	<xsl:value-of select="mods:namePart[@type='family']"/>
  	<xsl:if test="mods:namePart[@type='given']">
    <xsl:text>, </xsl:text>
    <xsl:value-of select="mods:namePart[@type='given']"/>
  	</xsl:if>
  	<xsl:if test="mods:namePart[@type='date']">
    <xsl:text>, </xsl:text>
    <xsl:value-of select="mods:namePart[@type='date']"/>
    <xsl:text/>
  	</xsl:if>
  	<xsl:if test="mods:namePart[@type='personal']">
    <xsl:text>, </xsl:text>
    <xsl:value-of select="mods:namePart[@type='personal']"/>
    <xsl:text/>
  	</xsl:if>

  	<xsl:if test="mods:displayForm">
    <xsl:text> (</xsl:text>
    <xsl:value-of select="mods:displayForm"/>
    <xsl:text>) </xsl:text>
  	</xsl:if>
  	<xsl:for-each select="mods:role[mods:roleTerm[@type='text']!='creator']">
    <xsl:text> (</xsl:text>
    <xsl:value-of select="normalize-space(.)"/>
    <xsl:text>) </xsl:text>
  	</xsl:for-each>
  </xsl:variable>
  <xsl:value-of select="normalize-space(name-value)"/>
-->
  </xsl:template>
  <!--
	<xsl:template match="mods:dateIssued[@point='start'] | mods:dateCreated[@point='start'] | mods:dateCaptured[@point='start'] | mods:dateOther[@point='start'] ">
  <xsl:variable name="dateName" select="local-name()"/>
  	<dc:date>
    <xsl:value-of select="."/>-<xsl:value-of select="../*[local-name()=$dateName][@point='end']"/>
  	</dc:date>
	</xsl:template>

	<xsl:template match="mods:temporal[@point='start']  ">
  <xsl:value-of select="."/>-<xsl:value-of select="../mods:temporal[@point='end']"/>
	</xsl:template>

	<xsl:template match="mods:temporal[@point!='start' and @point!='end']  ">
  <xsl:value-of select="."/>
	</xsl:template>
-->
  <!-- suppress all else:-->
  <xsl:template match="*" />

</xsl:stylesheet>
