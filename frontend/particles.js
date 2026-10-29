window.addEventListener("load", function () {
    Particles.init({
        selector: ".background",

        maxParticles: 70,
        sizeVariations: 4,
        speed: 0.3,

        color: [
            "#38bdf8",
            "#818cf8",
            "#ffffff"
        ],

        minDistance: 90,
        connectParticles: true
    });
});