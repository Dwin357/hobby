var scene = new THREE.Scene();
var camera = new THREE.PerspectiveCamera( 75, window.innerWidth/window.innerHeight, 0.1, 1000 );

var renderer = new THREE.WebGLRenderer();
renderer.setSize( window.innerWidth, window.innerHeight );

document.body.appendChild( renderer.domElement );


var rectLength = 120, rectWidth = 40;

var rectShape = new THREE.Shape();
rectShape.moveTo( 0,0 );
rectShape.lineTo( 0, rectWidth );
rectShape.lineTo( rectLength, rectWidth );
rectShape.lineTo( rectLength, 0 );
rectShape.lineTo( 0, 0 );

var rectGeom = new THREE.ShapeGeometry( rectShape );
var rectMesh = new THREE.Mesh( rectGeom, new THREE.MeshBasicMaterial( { color: 0xff0000 } ) ) ;

scene.add( rectMesh );



// var geometry = new THREE.BoxGeometry( 1, 1, 1 );
// var material = new THREE.MeshBasicMaterial( { color: 0x00ff00 } );
// var cube = new THREE.Mesh( geometry, material );
// scene.add( cube );

camera.position.z = 5;

var render = function () {
  requestAnimationFrame( render );

  // cube.rotation.x += 0.02;
  // cube.rotation.y += 0.001;
  // cube.rotation.z += 0.01;

  renderer.render(scene, camera);
};

render();