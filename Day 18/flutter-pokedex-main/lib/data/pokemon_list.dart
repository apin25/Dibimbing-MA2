import 'package:flutter/material.dart';

import '../models/pokemon.dart';

// ! Temporary
const List<Pokemon> pokemonList = [
  Pokemon(
    name: 'Bulbasaur',
    number: 1,
    types: ['Grass', 'Poison'],
    cardColor: Color(0xFF60D394),
    imageUrl:
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png',
    description:
        'A strange seed was planted on its back at birth. The plant sprouts and grows with this Pokémon.',
    heightMeters: 0.7,
    weightKg: 6.9,
    category: 'Seed',
    abilities: ['Overgrow', 'Chlorophyll'],
  ),
  Pokemon(
    name: 'Ivysaur',
    number: 2,
    types: ['Grass', 'Poison'],
    cardColor: Color(0xFF81E2B0),
    imageUrl:
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/2.png',
    description:
        'When the bulb on its back grows large, it appears to lose the ability to stand on its hind legs.',
    heightMeters: 1.0,
    weightKg: 13.0,
    category: 'Seed',
    abilities: ['Overgrow', 'Chlorophyll'],
  ),
  Pokemon(
    name: 'Venusaur',
    number: 3,
    types: ['Grass', 'Poison'],
    cardColor: Color(0xFF5DB08C),
    imageUrl:
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/3.png',
    description:
        'Its plant blooms when it is absorbing solar energy. It stays on the move to seek sunlight.',
    heightMeters: 2.0,
    weightKg: 100.0,
    category: 'Seed',
    abilities: ['Overgrow', 'Chlorophyll'],
  ),
  Pokemon(
    name: 'Charmander',
    number: 4,
    types: ['Fire'],
    cardColor: Color(0xFFFF8C7A),
    imageUrl:
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png',
    description:
        'It has a preference for hot things. When it rains, steam is said to spout from the tip of its tail.',
    heightMeters: 0.6,
    weightKg: 8.5,
    category: 'Lizard',
    abilities: ['Blaze', 'Solar Power'],
  ),
  Pokemon(
    name: 'Charmeleon',
    number: 5,
    types: ['Fire'],
    cardColor: Color(0xFFFF6B6B),
    imageUrl:
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/5.png',
    description:
        'It lashes about with its tail to knock down its foe. Once it weakens its foe, it finishes it off with fire.',
    heightMeters: 1.1,
    weightKg: 19.0,
    category: 'Flame',
    abilities: ['Blaze', 'Solar Power'],
  ),
  Pokemon(
    name: 'Charizard',
    number: 6,
    types: ['Fire', 'Flying'],
    cardColor: Color(0xFFFF6B81),
    imageUrl:
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/6.png',
    description:
        'Spits fire that is hot enough to melt boulders. Known to cause forest fires unintentionally.',
    heightMeters: 1.7,
    weightKg: 90.5,
    category: 'Flame',
    abilities: ['Blaze', 'Solar Power'],
  ),
  Pokemon(
    name: 'Squirtle',
    number: 7,
    types: ['Water'],
    cardColor: Color(0xFF76BDFE),
    imageUrl:
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/7.png',
    description:
        'Shoots water at prey while in the water. Withdraws into its shell when in danger.',
    heightMeters: 0.5,
    weightKg: 9.0,
    category: 'Tiny Turtle',
    abilities: ['Torrent', 'Rain Dish'],
  ),
  Pokemon(
    name: 'Wartortle',
    number: 8,
    types: ['Water'],
    cardColor: Color(0xFF5A9DF2),
    imageUrl:
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/8.png',
    description:
        'Often hides in water to stalk unwary prey. For swimming fast, it moves its ears to maintain balance.',
    heightMeters: 1.0,
    weightKg: 22.5,
    category: 'Turtle',
    abilities: ['Torrent', 'Rain Dish'],
  ),
  Pokemon(
    name: 'Blastoise',
    number: 9,
    types: ['Water'],
    cardColor: Color(0xFF4D8ED4),
    imageUrl:
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/9.png',
    description:
        'A brutal Pokémon with pressurized water jets on its shell. They are used for high-speed tackles.',
    heightMeters: 1.6,
    weightKg: 85.5,
    category: 'Shellfish',
    abilities: ['Torrent', 'Rain Dish'],
  ),
  Pokemon(
    name: 'Pikachu',
    number: 25,
    types: ['Electric'],
    cardColor: Color(0xFFFFD76F),
    imageUrl:
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png',
    description:
        'Pikachu that can generate powerful electricity have cheek sacs that are extra soft and super stretchy.',
    heightMeters: 0.4,
    weightKg: 6.0,
    category: 'Mouse',
    abilities: ['Static', 'Lightning Rod'],
  ),
];
