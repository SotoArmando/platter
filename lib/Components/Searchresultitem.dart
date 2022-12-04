import 'package:cancellation_token_http/http.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p_l_atter/Components/Textspace.dart';
import 'package:p_l_atter/GraphQl/Changenotifiers/Recipeid.dart';
import 'package:p_l_atter/GraphQl/Changenotifiers/Requestor.dart';
import 'package:p_l_atter/GraphQl/Changenotifiers/Savemodel.dart';
import 'package:p_l_atter/GraphQl/Restclient.dart';
import 'package:p_l_atter/Resources/localconfig/platterfont.dart';
import 'package:provider/provider.dart';

class SearchResultItem extends StatefulWidget {
  final dynamic data;
  SearchResultItem({Key? key, dynamic this.data}) : super(key: key);

  @override
  _SearchResultItemState createState() => _SearchResultItemState();
}

class _SearchResultItemState extends State<SearchResultItem> {
  String name = "";
  String author = "";
  String id = "";
  dynamic thumbnailurl = "";
  Requestor? providedRequestor;
  Savemodel? saveModel;
  Recipeid? providedRecipeid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name = widget.data?["recipe_name"] ?? "Classic Chicken Noodle Soup";
    author = "@Myfatsecret";
    id = widget.data?["recipe_id"] ?? "@Suggestic Premium";

    thumbnailurl = widget.data?["recipe_image"] ?? "";
    print("thumbnailurl");
    providedRequestor = Provider.of<Requestor>(context, listen: false);
    saveModel = Provider.of<Savemodel>(context, listen: false);
    providedRecipeid = Provider.of<Recipeid>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(bottom: pixelNumberfromFigma(13)),
        height: pixelNumberfromFigma(56),
        child: IntrinsicHeight(
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              Row(
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      alignment: Alignment.center,
                      color: Color(0xffC1E7F6),
                      child: Container(
                        width: pixelNumberfromFigma(47),
                        height: pixelNumberfromFigma(45.38),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(thumbnailurl),
                                fit: BoxFit.cover)),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: pixelNumberfromFigma(13),
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Textspace(
                      textOverflow: TextOverflow.visible,
                      text: name,
                      headsize: 0.0001,
                      size: 0,
                      style: GoogleFonts.inter(color: Color(0xff525252)),
                    ),
                  ),
                  SizedBox(
                    height: pixelNumberfromFigma(10),
                    child: Container(color: Colors.transparent),
                  ),
                  Flexible(
                    child: Textspace(
                      textOverflow: TextOverflow.clip,
                      headsize: 0.0001,
                      size: 0,
                      maxLines: 1,
                      text: author,
                      style: GoogleFonts.inter(color: Color(0xff222222)),
                    ),
                  ),
                ],
              )),
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/platter/Vector0.svg",
                    height: pixelNumberfromFigma(25),
                  ),
                  SizedBox(
                    width: pixelNumberfromFigma(2.5),
                  )
                ],
              )
            ])),
      ),
      onTap: () {
        Navigator.pushNamed(context, '/details');
        providedRecipeid?.update(id);
        providedRequestor?.addRequest("recipe_id $id",
            (CancellationToken token) => RestClient().recipesDetail(id),
            now: true);

        Future(() async {
          await Future<void>.delayed(const Duration(seconds: 5));
          providedRequestor?.addRequest(
              "addhistory${DateTime.now().millisecondsSinceEpoch}",
              (CancellationToken token) => RestClient().addFavoriteToProfile(
                    saveModel?.history["auth_token"]! ?? "",
                    saveModel?.history["auth_secret"]! ?? "",
                    id,
                  ),
              now: true);
        });
      },
    );
  }
}
