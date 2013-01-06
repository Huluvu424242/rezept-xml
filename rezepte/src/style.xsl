<?xml version="1.0" encoding="UTF-8"?>
<?thomas-michel document-status="draft" version="2.0"?>
<!-- $Id$ -->
<!-- =================================================== -->
<!-- |style.xsl         |         -  TODO description  | -->
<!--                                                     -->
<!-- begin            : | 24.09.2006|                  | -->
<!-- copyright        : | (C) 2006 by tmichel          | -->
<!-- email            : | funthomas424242@gmail.com    | -->
<!-- =================================================== -->
<!--
 ******************************************************************************
 *                                                                            *
 *   This document is a free paper; you can redistribute it and/or modify     *
 *   it under the terms of the GNU Free Documentation License as published    *
 *   by the Free Software Foundation; either version 1.2 of the License, or   *
 *   (at your option) any later version.                                      *
 *                                                                            *
 ******************************************************************************
 -->


<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/TR/WD-xsl/FO">
	
		
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>		
	
	<xsl:template match="rezepte">
		<HTML>
		<HEAD>
			<META HTTP-EQUIV="CONTENT-TYPE" CONTENT="text/html; charset=windows-1252"/>
			<TITLE>
				<xsl:choose>
					<xsl:when test="@titel">
						<xsl:value-of select="@titel"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="rezept[0]/titel"/>
					</xsl:otherwise>
				</xsl:choose>
			</TITLE>
			<META NAME="GENERATOR" CONTENT="style.xsl  (Win32)"/>
			<META NAME="AUTHOR" CONTENT="Thomas Schubert"/>
			<META NAME="CREATED" CONTENT="20060918;10562721"/>
			<META NAME="CHANGEDBY" CONTENT="Thomas Schubert"/>
			<META NAME="CHANGED" CONTENT="20060918;10572700"/>
		</HEAD>
		<BODY LANG="de-DE" DIR="LTR">
			<xsl:apply-templates/>
		</BODY>
		</HTML>
	</xsl:template>
	
	<xsl:template match="rezept">
		<h1> <xsl:value-of select="titel"/></h1>
		<xsl:apply-templates select="untertitel"/>		
		<xsl:apply-templates select="quelle"/>
		<xsl:apply-templates select="ungetestet|test"/>
		<xsl:apply-templates select="produkte"/>
		<xsl:apply-templates select="beilagen"/>		
		<xsl:apply-templates select="zutaten"/>
		<xsl:apply-templates select="zubereitung"/>
		<xsl:apply-templates select="tipps"/>
	</xsl:template>
	
	<xsl:template match="ungetestet">
		<h3>Testbemerkung</h3>
		Danger - Das Rezept wurde noch nicht ausprobiert!!!
	</xsl:template>
	
	<xsl:template match="test">
		<h3>Testbemerkung</h3>
		<xsl:for-each select="bemerkung">
			<xsl:value-of select="."/><br/>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template match="produkte">
		<h3>Vorschläge fürs Einkaufen</h3>
		<ul>
		<xsl:for-each select="produkt">
			<li>
				<strong>
				<xsl:value-of select="@beschreibung"/>
				</strong>
				<xsl:if test="@ean">
					<br/>
					<xsl:if test="@ean">
					EAN: <xsl:value-of select="@ean"/>
					</xsl:if> 
					<xsl:if test="@uba">
					UBA: <xsl:value-of select="@uba"/>
					</xsl:if>
				</xsl:if>
				<xsl:if test="@hersteller">
					<br/>von <xsl:value-of select="@hersteller"/>
				</xsl:if>
				<xsl:if test="@preis">
					für ca. <xsl:value-of select="@preis"/>
				</xsl:if>
				<xsl:apply-templates/>
			</li>
		</xsl:for-each>
		</ul>
	</xsl:template>

	<xsl:template match="beilagen">
		<h3>Vorschläge für Beilagen</h3>
		<ul>
		<xsl:for-each select="beilage">
			<li>
				<xsl:value-of select="."/>
			</li>
		</xsl:for-each>
		</ul>
	</xsl:template>

	<xsl:template match="untertitel">
		<h2>( <xsl:value-of select="."/>)</h2>
	</xsl:template>

	<xsl:template match="quelle">
		<h3>Quellenangaben</h3>
		Inhaltlich
		<xsl:choose>
			<xsl:when test="@modifiziert">
			verändert
			</xsl:when>
			<xsl:otherwise>
			unverändert
			</xsl:otherwise>
		</xsl:choose>
		übernommen
		aus <strong><xsl:value-of select="@name"/></strong>
	
	</xsl:template>
	
	<xsl:template match="zutaten">
		<h3>Zutaten</h3>
		<ul>
		<xsl:for-each select="zutat">
			<li>
				<!-- Anker einfügen -->
				<xsl:element name="a">
					<!-- muss auf einer Zeile stehen, sonst klappt der Anker nicht -->
					<xsl:attribute name="name">zutat_<xsl:value-of select="@code"/></xsl:attribute>
					<xsl:value-of select="@menge"/>
					<xsl:value-of select="@einheit"/>
					<strong>
					<!--fo:block font-size="23pt"-->
						<xsl:value-of select="@name"/>
					<!--/fo:block-->
					</strong>
				</xsl:element>	
				<xsl:apply-templates/>
			</li>
		</xsl:for-each>
		</ul>
	</xsl:template>
	
	<xsl:template match="zubereitung">
		<h3>Arbeitsschritte</h3>
		<ol>
		<xsl:for-each select="aktion">
			<li>
				<xsl:apply-templates />
			</li>
		</xsl:for-each>
		</ol>
	</xsl:template>
	
	<xsl:template match="tipps">
		<h3>Hinweise</h3>
		<ul>
		<xsl:for-each select="tipp">
			<li>
				<xsl:apply-templates />
			</li>
		</xsl:for-each>
		</ul>	
	</xsl:template>
	
	<!-- 
	<xsl:template match="./text()">
		<xsl:value-of select="."/>
	</xsl:template>
	-->
		
	<xsl:template match="zutatref">
		<a>
			<xsl:attribute name="href">
				#zutat_<xsl:value-of select="@code"/> 
			</xsl:attribute>
			<xsl:value-of select="."/>
		</a>
	</xsl:template>

	
</xsl:stylesheet>