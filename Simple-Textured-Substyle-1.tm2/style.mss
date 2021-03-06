// Languages: name (local), name_en, name_fr, name_es, name_de
@name: '[name_en]';

// Fonts //
@sans: 'Arial Unicode MS Regular';
@sans_bold: 'Arial Unicode MS Bold';

/*
This style is designed to be easily recolored by adjusting the color
variables below. For predicatable feature relationships,
maintain or invert existing value (light to dark) scale.
*/

// Color palette //
@road:  #fff;
@land:  #eee;

@fill1: #fff;
@fill2: #bbb;
@fill3: #777;
@fill4: #000;

@text1: #fff;
@text2: #bbb;
@text3: #777;
@text4: #666;

//Texture palette
@landtex: url('img\textures\paper-vin-2.jpg');

@tex1: url('img\textures\squairy_light_2X.png');
@tex2: url('img\textures\sandstone-2.jpg');
@tex3: url('img\textures\paper-vin-green-2.jpg');
@tex4: url('img\textures\paper-vin-green-1.jpg');
@tex5: url('img\textures\paper-vin-blue-1.jpg');
@tex6: url('img\textures\paper-vin-red-1.jpg');
@tex7: url('img\textures\paper-vin-yellow-1.jpg');

Map { background-color: @land; }

// Political boundaries //
#admin[admin_level=2][maritime=0] {
  line-join: round;
  line-color: mix(@fill3,@fill2,50);
  line-width: 1;
  [zoom>=5] { line-width: 1.4; }
  [zoom>=6] { line-width: 1.8; }
  [zoom>=8] { line-width: 2; }
  [zoom>=10] { line-width: 3; }
  [disputed=1] { line-dasharray: 4,4; }
}

#admin[admin_level>2][maritime=0] {
  line-join: round;
  line-color: @fill2;
  line-width: 1;
  line-dasharray: 3,2;
  [zoom>=6] { line-width: 1.5; }
  [zoom>=8] { line-width: 1.8; }
}

// Land Features //
#landuse[class='cemetery'],
#landuse[class='park'],
#landuse[class='wood'],
#landuse_overlay {
  polygon-opacity: 170;
  polygon-fill: #939393;
  [zoom>=16]{ polygon-opacity: 150;
              polygon-fill: #939393;}
}

#landuse[class='pitch'],
#landuse[class='sand'] { 
  polygon-opacity: 170;
  polygon-fill: #838383;
  [zoom>=16]{ polygon-opacity: 150;
              polygon-fill: #838383;}
}

#landuse[class='hospital'], {
  polygon-opacity: 170;
  polygon-fill: #003dff;
  [zoom>=16]{ polygon-opacity: 150;
              polygon-fill: #003dff;}
}
  
#landuse[class='industrial'], {
  polygon-opacity: 170;
  polygon-fill: #fff800;
  [zoom>=16]{ polygon-opacity: 150;
              polygon-fill: #fff800;}
}
  
#landuse[class='school'] { 

}

#building {
  polygon-opacity: 170;
  polygon-fill: #000;
  [zoom>=16]{ polygon-opacity: 150;
              polygon-fill: #000;}
}

#aeroway {
  ['mapnik::geometry_type'=3][type!='apron'] { 
    polygon-fill: mix(@fill2,@land,25);
    [zoom>=16]{ polygon-fill: mix(@fill2,@land,50);}
  }
  ['mapnik::geometry_type'=2] { 
    line-color: mix(@fill2,@land,25);
    line-width: 1;
    [zoom>=13][type='runway'] { line-width: 4; }
    [zoom>=16] {
      [type='runway'] { line-width: 6; }
      line-width: 3;
      line-color: mix(@fill2,@land,50);
    }
  }
}

// Water Features //
#water {
  ::shadow {
    polygon-fill: mix(@land,@fill4,75);
  }
  ::fill {
    // a fill and overlay comp-op lighten the polygon-
    // fill from ::shadow.
    polygon-fill: @land;
    comp-op: soft-light;
    // blurring reveals the polygon fill from ::shadow around
    // the edges of the water
    image-filters: agg-stack-blur(10,10);
  }
}

// Water color is calculated by sampling the resulting color from
// the soft-light comp-op in the #water layer style above. 
@water: #d1d1d1;

#waterway {
  [type='river'],
  [type='canal'] {
    line-color: @water;
    line-width: 0.5;
    [zoom>=12] { line-width: 1; }
    [zoom>=14] { line-width: 2; }
    [zoom>=16] { line-width: 3; }
  }
  [type='stream'] {
    line-color: @water;
    line-width: 0.5;
    [zoom>=14] { line-width: 1; }
    [zoom>=16] { line-width: 2; }
    [zoom>=18] { line-width: 3; }
  }
}
