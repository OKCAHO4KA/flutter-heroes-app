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
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
          width: (MediaQuery.sizeOf(context).width - 32) / 2 - 10,
          height: 210,
        ),
        Container(
          width: (MediaQuery.sizeOf(context).width - 32) / 2 - 10,
          height: 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(GeneralConstants.borderRadiusDefault),
            ),
          ),
          clipBehavior: Clip.hardEdge,
          child: CachedNetworkImage(
            imageUrl: heroe.image,
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator(strokeWidth: 2)),
            errorWidget: (context, url, error) =>
                Image.asset('assets/images/placeholder.jpg', fit: BoxFit.cover),
          ),
        ),
        Container(
          width: (MediaQuery.sizeOf(context).width - 32) / 2 - 10,
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
                  isFavorite ? Icons.star_rounded : Icons.star_border_rounded,
                  color: theme.primaryColor,
                  size: 40,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            decoration: BoxDecoration(
              color: theme.colorCard,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(GeneralConstants.borderRadiusDefault),
              ),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: GeneralConstants.padding10,
            ),
            width: (MediaQuery.sizeOf(context).width - 32) / 2 - 10,
            height: 65,
            child: ItemText(heroe: heroe),
          ),
        ),
      ],
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
        lineText(heroe.name, theme.bold15),
        lineText(heroe.location.name, theme.medium10),
        lineText(heroe.origin.name, theme.medium10),
        lineText(heroe.species.name, theme.medium10),
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
