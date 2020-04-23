import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:knee_kinematic_monitor/stores/global_settings.dart';
import 'package:knee_kinematic_monitor/stores/homepage.store.dart';
import 'package:provider/provider.dart';
import 'package:quiver/async.dart';

class IntroductionPage extends StatefulWidget {
  Icon getBottomIcon(BuildContext context) {
    final homePageStore = Provider.of<HomePageStore>(context);

    Color color = Colors.white;
    IconData icon = Icons.favorite_border;

    if (homePageStore.introductionPageDone) {
      color = Colors.redAccent;
      icon = Icons.favorite;
    }

    return Icon(icon, color: color);
  }

  @override
  _IntroductionPageState createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  @override
  void dispose() {
    super.dispose();
    if (countdownSubscriber != null && countDownTimer != null) {
      countdownSubscriber.cancel();
      countDownTimer.cancel();
    }
  }

  static int _start = AppGlobalSettings.countdownDuration;
  int _current  = AppGlobalSettings.countdownDuration;
  CountdownTimer countDownTimer = new CountdownTimer(
    new Duration(seconds: _start),
    new Duration(seconds: 1),
  );
  StreamSubscription<CountdownTimer> countdownSubscriber;

  void startTimer(BuildContext context) {
    final homePageStore = Provider.of<HomePageStore>(context, listen: false);

    countdownSubscriber = countDownTimer.listen(null);
    countdownSubscriber.onData((duration) {
      setState(() {
        _current = _start - duration.elapsed.inSeconds;
      });
    });

    countdownSubscriber.onDone(() {
      countdownSubscriber.cancel();
      countDownTimer.cancel();
      homePageStore.setIntroductionPageDone(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final homePageStore = Provider.of<HomePageStore>(context);

    Future.delayed(Duration(milliseconds: 500), () {
      if (countdownSubscriber == null &&
          !homePageStore.introductionPageDone &&
          homePageStore.currentPageIndex == homePageStore.introductionPageIndex) {
        startTimer(context);
      }
    });

    return Stack(
      children: <Widget>[
        Container(
          child: Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    """
Introdução - Explicações sobre o APP, como o motivo de sua existência.

Introduction - About the APP, purpose, etc.

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suam denique cuique naturam esse ad vivendum ducem. Satis est tibi in te, satis in legibus, satis in mediocribus amicitiis praesidii. Nunc ita separantur, ut disiuncta sint, quo nihil potest esse perversius. Hunc ipsum Zenonis aiunt esse finem declarantem illud, quod a te dictum est, convenienter naturae vivere. Duo Reges: constructio interrete. Si verbum sequimur, primum longius verbum praepositum quam bonum. Deinde dolorem quem maximum? Atqui haec patefactio quasi rerum opertarum, cum quid quidque sit aperitur, definitio est.

Perturbationes autem nulla naturae vi commoventur, omniaque ea sunt opiniones ac iudicia levitatis. Cum audissem Antiochum, Brute, ut solebam, cum M. Numquam audivi in Epicuri schola Lycurgum, Solonem, Miltiadem, Themistoclem, Epaminondam nominari, qui in ore sunt ceterorum omnium philosophorum. Reperiam multos, vel innumerabilis potius, non tam curiosos nec tam molestos, quam vos estis, quibus, quid velim, facile persuadeam. Non igitur de improbo, sed de callido improbo quaerimus, qualis Q. Aut etiam, ut vestitum, sic sententiam habeas aliam domesticam, aliam forensem, ut in fronte ostentatio sit, intus veritas occultetur? Nunc reliqua videamus, nisi aut ad haec, Cato, dicere aliquid vis aut nos iam longiores sumus. Quem si tenueris, non modo meum Ciceronem, sed etiam me ipsum abducas licebit. Commentarios quosdam, inquam, Aristotelios, quos hic sciebam esse, veni ut auferrem, quos legerem, dum essem otiosus; Tanti autem aderant vesicae et torminum morbi, ut nihil ad eorum magnitudinem posset accedere. Illud quaero, quid ei, qui in voluptate summum bonum ponat, consentaneum sit dicere. Et quidem Arcesilas tuus, etsi fuit in disserendo pertinacior, tamen noster fuit;

Num igitur dubium est, quin, si in re ipsa nihil peccatur a superioribus, verbis illi commodius utantur? Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat.

Atqui, inquit, si Stoicis concedis ut virtus sola, si adsit vitam efficiat beatam, concedis etiam Peripateticis. Omnes enim iucundum motum, quo sensus hilaretur. Quis animo aequo videt eum, quem inpure ac flagitiose putet vivere? Infinitio ipsa, quam apeirian vocant, tota ab illo est, tum innumerabiles mundi, qui et oriantur et intereant cotidie. -, sed ut hoc iudicaremus, non esse in iis partem maximam positam beate aut secus vivendi. Quae cum praeponunt, ut sit aliqua rerum selectio, naturam videntur sequi; Quibus rebus vita consentiens virtutibusque respondens recta et honesta et constans et naturae congruens existimari potest. Hi curatione adhibita levantur in dies, valet alter plus cotidie, alter videt.

An dubium est, quin virtus ita maximam partem optineat in rebus humanis, ut reliquas obruat? Nunc dicam de voluptate, nihil scilicet novi, ea tamen, quae te ipsum probaturum esse confidam. Consequens enim est et post oritur, ut dixi. Quis contra in illa aetate pudorem, constantiam, etiamsi sua nihil intersit, non tamen diligat? Quae quidem adhuc peregrinari Romae videbatur nec offerre sese nostris sermonibus, et ista maxime propter limatam quandam et rerum et verborum tenuitatem. Ita fit cum gravior, tum etiam splendidior oratio. Scaevola tribunus plebis ferret ad plebem vellentne de ea re quaeri. Atque ut ceteri dicere existimantur melius quam facere, sic hi mihi videntur facere melius quam dicere. Nam illud quidem adduci vix possum, ut ea, quae senserit ille, tibi non vera videantur. Stoici scilicet. Tenesne igitur, inquam, Hieronymus Rhodius quid dicat esse summum bonum, quo putet omnia referri oportere? Id et fieri posse et saepe esse factum et ad voluptates percipiendas maxime pertinere. Polemoni et iam ante Aristoteli ea prima visa sunt, quae paulo ante dixi. Qua ex cognitione facilior facta est investigatio rerum occultissimarum. Possumusne ergo in vita summum bonum dicere, cum id ne in cena quidem posse videamur?
                    """,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.bottomRight,
          margin: EdgeInsets.only(right: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            child: Container(
              constraints: BoxConstraints.tight(Size((homePageStore.introductionPageDone ? 50.0 : 80.0), 40.0)),
              color: Theme.of(context).primaryColor,
              child: Row(
                children: <Widget>[
                  Spacer(),
                  (homePageStore.introductionPageDone
                      ? Container()
                      : Text(
                          ((_current > 0 && !homePageStore.introductionPageDone) ? "$_current" : ""),
                          style: Theme.of(context).primaryTextTheme.subhead.copyWith(color: Colors.white),
                        )),
                  IconButton(
                    icon: Observer(
                      builder: (_) => Icon(
                        Icons.arrow_forward_ios,
                        color: (homePageStore.introductionPageDone ? Colors.lightGreenAccent : Colors.white),
                      ),
                    ),
                    onPressed: () {
                      //homePageStore.setIntroductionPageDone(true);
                      homePageStore.pageController.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
