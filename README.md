# Protective Visor for covid19 pandemic

## Design for Reusable Headband with Low Cost Replacement Shields

The urgent need for personal protection equipment in this time of covid19 pandemic is the motivation for these documents.

![Assembled visor](IMG_20200325_170538_small.jpg)


### For Users:

Visors to shield the face are the first contact line of defense when confronted with infected persons.  It is the purpose of these designs to provide a reusable headband that supports low cost, easily replacable shields.  Cheap plastic shields can consist of transparency sheets, lamination sheets, or other clear plastic sheets.

To make shields easy to obtain in the US market, a standard three-hole punch design is utilized.  Thus high volume production of shields requires only a ream of transparency sheets and a three-hole punch, both of which are widely available.  Alternate shield materials can also be used if dimensioned to the standard 11" width.

For other locations than US, the original designer, [Prusa](https://www.prusaprinters.org/prints/25857-prusa-protective-face-shield-rc1), has a four-hole punch design.

Instructions:

- [Threading](LoopThread/ThreadInstructions.md) of band for cinch design.  Tip:  The elastic band should be approximately 18" (38 mm).
- Making shields for [three-hole design](3HoleShieldInstructions.md)
- Making top [brow shields](BrowShieldInstructions.md) for three-hole design
- Making shields for four-hole design using [cut template](PrusaFaceShieldHolesRC2.pdf)


### For Makers:

Help generate headbands for our urgent care providers!  They deperately need your help.  Choose a design the fits the elastic band that you can obtain, or modify to your own design.  Here you will find:

STL models for your slicer (PETG is recommended material, 0.4mm nozzle, 0.2mm height, 20% infill):

- Three-hole headband with [cinch design](stl/covid19_headband_3hole_cinch.stl) for flat 3/4" (38mm) elastic bands (non-elastic should also work)
- Three-hole headband with [button design](stl/covid19_headband_3hole_button.stl) for button hole elastic band
- Four-hole headband with [cinch design](stl/covid19_headband_rc2_cinch.stl)
- Four-hole [original Prusa design](covid19_headband_rc2.stl) with button design

Design tools used here so you can do your own modifications:

- OpenSCAD design [software](https://www.openscad.org/)
- OpenSCAD [code](covid19_headband_mods.scad) used to generate modified STL model (choose type and strap dimensions)

![Modified headband](IMG_20200323_084829_small.jpg)


Thanks Josef Prusa for your open design upon which this visor is based.  Original model was obtained [here](https://www.prusaprinters.org/prints/25857-prusa-protective-face-shield-rc1).  Their [link](https://www.prusaprinters.org/prints/25857-prusa-protective-face-shield-rc1) provides good documentation of the design and use.  The modifications here were made to support rapid local use.
