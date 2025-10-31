import 'package:prueba_jun/library.dart';

class ItemHeroeWidget extends StatelessWidget {
  const ItemHeroeWidget({
    super.key,
    required this.heroe,
    this.onTapStar,
    required this.isFavorite,
  });

  final Heroe heroe;
  final VoidCallback? onTapStar;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    final theme = UIThemes.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          GeneralConstants.borderRadiusDefault,
        ),
        border: Border.all(color: theme.primaryColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: GeneralConstants.padding10,
            ),
            width: MediaQuery.sizeOf(context).width - 42 - 160,
            height: 162,
            child: ItemText(heroe: heroe),
          ),
          Stack(
            children: [
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(
                      GeneralConstants.borderRadiusDefault,
                    ),
                    bottomRight: Radius.circular(
                      GeneralConstants.borderRadiusDefault,
                    ),
                  ),
                ),
                clipBehavior: Clip.hardEdge,
                child: CachedNetworkImage(
                  imageUrl: heroe.image,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/images/placeholder.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: 160,
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: GeneralConstants.paddingHorizontal,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        onTapStar != null ? onTapStar!() : null;
                      },
                      child: Icon(
                        isFavorite
                            ? Icons.star_rounded
                            : Icons.star_border_rounded,
                        color: theme.primaryColor,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ItemText extends StatelessWidget {
  const ItemText({super.key, required this.heroe});
  final Heroe heroe;

  @override
  Widget build(BuildContext context) {
    final theme = UIThemes.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        lineText(heroe.name, theme.bold20),
        lineText(heroe.location.name, theme.medium15),
        lineText(heroe.origin.name, theme.medium15),
        lineText(heroe.species.name, theme.medium15),
        lineText(heroe.status.name, theme.medium15),
      ],
    );
  }
}

Text lineText(String text, TextStyle textStyle) {
  return Text(
    text,
    style: textStyle,
    overflow: TextOverflow.ellipsis,
    maxLines: 1,
  );
}
