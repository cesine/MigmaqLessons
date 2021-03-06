<?xml version="1.0" encoding="UTF-8"?>
<!--This transformation creates a webpage for a unit. It matches on a given unit node and displays the unit title, img, intro, and all dialogs or vocabs included in the unit.-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="/lesson"><!--Match on current unit node-->
    <h1 class="title">
      <xsl:value-of select="title"/>
    </h1><!--Display unit title at top of page-->
    <div class="row">
      <xsl:variable name="divClass">
        <xsl:choose>
          <xsl:when test="img">col-md-8</xsl:when>
          <xsl:otherwise>col-md-10</xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <div class="{$divClass}">&#160;
        <xsl:for-each select="note">
          <p>
            <xsl:apply-templates/>
          </p><!--Display any notes about the lesson-->
        </xsl:for-each>
      </div>
      <xsl:choose>
        <xsl:when test="img"><!--Display image if there is one, else display default-->
          <div class="col-md-4">
            <xsl:variable name="main_img"><xsl:value-of select="img"/></xsl:variable>
            <img class="img-responsive thumbnail" src="{$main_img}" alt="Trees" style="max-width: 75%"/>
          </div>
        </xsl:when>
        <xsl:otherwise>
        </xsl:otherwise>
      </xsl:choose>
    </div>
    <xsl:if test="dialog"><!--if there are dialogs, display them-->
      <div class="well well-lg">
        <div id="dialogHeading">Dialog 1</div>
        <div id="allDialogs">      <!--when combined with nav.js, this iterates through the dialogs one at a time-->
          <xsl:for-each select="dialog">
            <div class="container"><!-- if you want to display 1 line at a time, remove this div-->
              <xsl:for-each select="line">
                <div class="row">
                  <div class="col-md-1">&#160;
                    <xsl:if test="soundfile"><!-- Link to audio file if there is one-->
                      <button class="btn btn-default" type="button">
                        <span class="glyphicon glyphicon-play" aria-hidden="true">
                          <audio>
                            <xsl:variable name="soundurl">{{ site.baseurl }}/audio/<xsl:value-of select="soundfile"/>.mp3</xsl:variable>
                            <source src="{$soundurl}" type="audio/mpeg"/>
                          </audio>
                        </span>
                      </button>
                    </xsl:if>
                  </div>
                  <div class="col-md-8">
                    <h2 class="media-heading">
                      <xsl:for-each select="migmaq">
                        <xsl:value-of select="."/>
                        <xsl:apply-templates/>
                      </xsl:for-each>
                    </h2><!--Display Mi'gmaq-->
                    <h4 class="media-heading">
                      <xsl:value-of select="english"/>
                    </h4><!--Display English-->
                  </div> 
                  <div class="col-md-2">&#160;
                    <xsl:if test="img">
                      <xsl:variable name="d_img">{{ site.baseurl }}/emoji/<xsl:value-of select="img"/></xsl:variable>
                      <img class="img-responsive thumbnail" src="{$d_img}" alt="Trees" style="width: 64px"/>
                    </xsl:if>
                  </div>
                </div>
              </xsl:for-each>
            </div>
          </xsl:for-each>
          <ul class="pager"><!--navigation arrows to page through dialogs-->
            <li class = "previous">
              <a href="#" id="prevDialog"><span aria-hidden="true"><xsl:text disable-output-escaping="yes">&#8592;</xsl:text></span>Previous Dialog</a>
            </li>
            <li class = "next">
              <a href="#" id="nextDialog">Next Dialog<span aria-hidden="true"><xsl:text disable-output-escaping="yes">&#8594;</xsl:text></span></a>
            </li>
          </ul>
        </div>
      </div>
    </xsl:if>
    <xsl:if test="vocab"><!-- If there are vocab sections, display them-->
      <div class="well well-lg"> 
        <div id="vocabHeading">Vocabulary Section 1</div>
        <div id="allVocabs">     <!--when combined with nav.js, this iterates through the vocabs one at a time-->
          <xsl:for-each select="vocab">
            <div class="container"><!-- if you want to display 1 line at a time, remove this div-->
              <xsl:for-each select="line">
                <div class="row">
                  <div class="col-md-1">&#160;
                    <xsl:if test="soundfile"><!-- Link to audio file if there is one-->
                      <xsl:variable name="soundurl">{{ site.baseurl }}/audio/<xsl:value-of select="soundfile"/>.mp3</xsl:variable>
                      <button class="btn btn-default" type="button">
                        <span class="glyphicon glyphicon-play" aria-hidden="true">
                          <audio>
                            <source src="{$soundurl}" type="audio/mpeg"/>
                          </audio>
                        </span>
                      </button>
                    </xsl:if>
                  </div>
                  <div class="col-md-8">
                    <h2 class="media-heading">
                      <xsl:for-each select="migmaq">
                        <xsl:value-of select="."/>
                        <xsl:apply-templates/>
                      </xsl:for-each>
                    </h2><!--Display Mi'gmaq-->
                    <h4 class="media-heading">
                      <xsl:value-of select="english"/>
                    </h4><!--Display English-->  
                  </div>
                  <div class="col-md-2">&#160;
                    <xsl:if test="img">
                      <xsl:variable name="vimg">{{ site.baseurl }}/emoji/<xsl:value-of select="img"/></xsl:variable>
                      <img class="img-responsive thumbnail" src="{$vimg}" alt="Trees" style="width: 64px"/>
                    </xsl:if>
                  </div>
                </div>
              </xsl:for-each>
            </div>
          </xsl:for-each>
          <ul class="pager"><!-- navigation arrows to page through vocabs-->
            <li class = "previous">
              <a href="#" id="prevVocab"><span aria-hidden="true"><xsl:text disable-output-escaping="yes">&#8592;</xsl:text></span>Previous Vocabulary</a>
            </li>
            <li class = "next">
              <a href="#" id="nextVocab">Next Vocabulary<span aria-hidden="true"><xsl:text disable-output-escaping="yes">&#8594;</xsl:text></span></a>
            </li>
          </ul>
        </div>
      </div>
    </xsl:if>
    <p>
      <xsl:value-of select="info"/><!--Display any info associated with the lesson-->
    </p>
  </xsl:template>
  <!--<xsl:template match="m">
    <strong><xsl:value-of select="."/></strong>
  </xsl:template>-->
  <xsl:template match="migmaq">
    <xsl:variable name="s1"><xsl:value-of select="."/></xsl:variable>
    <xsl:choose>
      <xsl:when test="contains($s1,'e')">
        <xsl:value-of select="substring-before($s1,'e')"/>
        <xsl:value-of select="a"/>
        <xsl:call-template name="replace-string">
          <xsl:with-param name="s1"
select="substring-after($s1,'e')"/>
          <xsl:with-param name="a" select="$replace"/>
          <xsl:with-param name="with" select="$with"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$text"/>
      </xsl:otherwise>
    </xsl:choose>
    
    <xsl:value-of select="replace($s1,'a','e')"/>
    <!--<xsl:analyze-string select="." regex="e">
      <xsl:matching-substring>a</xsl:matching-substring>
      <xsl:non-matching-substring><xsl:value-of select="."/></xsl:non-matching-substring>
    </xsl:analyze-string>-->
  </xsl:template>
</xsl:stylesheet>
