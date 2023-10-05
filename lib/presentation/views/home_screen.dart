import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:poked3x/common/extension/context_utils.dart';
import 'package:poked3x/common/extension/extension.dart';
import 'package:poked3x/presentation/viewmodels/main_viewmodel.dart';
import 'package:poked3x/presentation/widgets/loading_image.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Positioned(
                  right: -64,
                  top: -64,
                  child: Opacity(
                    opacity: 0.5,
                    child: Image.asset(
                      "assets/images/pokeball_grey.png",
                      width: 256,
                    ),
                  )),
              Positioned.fill(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 32,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Pokedex",
                          style: context.headlineLarge
                              ?.copyWith(color: Colors.black),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.format_list_bulleted_rounded),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Expanded(
                      child: Builder(builder: (context) {
                        final listState =
                            context.watch<MainViewmodel>().listState;
                        if (listState.isLoading && listState.data == null) {
                          return const Center(
                            child: LoadingImage(
                                imagePath: "assets/images/pokeball_grey3.png"),
                          );
                        }
                        if (listState.isError && listState.data == null) {
                          return Center(
                            child: Text(listState.errorMessage ?? ""),
                          );
                        }
                        final pokemons = listState.data ?? [];
                        return GridView.builder(
                          shrinkWrap: true,
                          itemCount: pokemons.length,
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.0,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                          ),
                          itemBuilder: (context, index) {
                            final pokemon = pokemons[index];
                            return InkWell(
                              onTap: () {
                                context.push("/${pokemon.id}");
                                context
                                    .read<MainViewmodel>()
                                    .fetchDetailPokemon(id: pokemon.id);
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 16, 8, 8),
                                decoration: BoxDecoration(
                                  color: pokemon.color.colorNameAsColor,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          pokemon.name,
                                          style: context.titleLarge
                                              ?.copyWith(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "#${pokemon.id}",
                                          style: context.titleLarge
                                              ?.copyWith(color: Colors.white),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Expanded(
                                          child: Image.network(
                                            pokemon.imageUrl,
                                            width: 64,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
