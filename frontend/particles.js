window.addEventListener("load", function () {
    Particles.init({
        selector: ".background", // Identifica a div do fundo pela classe

        maxParticles: 80,        // Define o número máximo de particulas
        sizeVariations: 3,       // Define a variação do tamanho das particulas
        speed: 0.15,             // Define a velocidade das particulas

        color: [                 // Cores sorteadas pelas particulas
            "#75f838",
            "#818cf8",
            "#ffffff"
        ],

        minDistance: 60,
        connectParticles: false
    });
});