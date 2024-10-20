// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again
// with `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types, depend_on_referenced_packages
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'
    as obx_int; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart' as obx;
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'models/author.dart';
import 'models/episode.dart';
import 'models/podcast.dart';
import 'models/schedule.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <obx_int.ModelEntity>[
  obx_int.ModelEntity(
      id: const obx_int.IdUid(13, 344636043584780291),
      name: 'Author',
      lastPropertyId: const obx_int.IdUid(3, 5494833420627835458),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 7810199316274952016),
            name: 'id',
            type: 6,
            flags: 1),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 2384362113340254133),
            name: 'name',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 5494833420627835458),
            name: 'isGuest',
            type: 1,
            flags: 0)
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[]),
  obx_int.ModelEntity(
      id: const obx_int.IdUid(14, 3142224122661868782),
      name: 'Podcast',
      lastPropertyId: const obx_int.IdUid(10, 7925460019805255390),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 8648182815062226891),
            name: 'id',
            type: 6,
            flags: 1),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 6561944832059457373),
            name: 'podcastId',
            type: 6,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 2214972437586686240),
            name: 'podcastName',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(4, 5595129068527183540),
            name: 'onlyMusic',
            type: 1,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(5, 8669039130560720763),
            name: 'isActive',
            type: 1,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(6, 1171160963366421378),
            name: 'hasEpisodes',
            type: 1,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(8, 4727659054825687222),
            name: 'isFavorited',
            type: 1,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(10, 7925460019805255390),
            name: 'image',
            type: 9,
            flags: 0)
      ],
      relations: <obx_int.ModelRelation>[
        obx_int.ModelRelation(
            id: const obx_int.IdUid(5, 8340345488484673401),
            name: 'authors',
            targetId: const obx_int.IdUid(13, 344636043584780291)),
        obx_int.ModelRelation(
            id: const obx_int.IdUid(6, 7419335105193171846),
            name: 'schedules',
            targetId: const obx_int.IdUid(15, 4264369388591353841))
      ],
      backlinks: <obx_int.ModelBacklink>[]),
  obx_int.ModelEntity(
      id: const obx_int.IdUid(15, 4264369388591353841),
      name: 'Schedule',
      lastPropertyId: const obx_int.IdUid(4, 7875991149166202491),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 4117873641574141640),
            name: 'id',
            type: 6,
            flags: 1),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 8694338694909941471),
            name: 'weekday',
            type: 6,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 9093295015931203146),
            name: 'start',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(4, 7875991149166202491),
            name: 'end',
            type: 9,
            flags: 0)
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[]),
  obx_int.ModelEntity(
      id: const obx_int.IdUid(41, 6594091496338156520),
      name: 'Episode',
      lastPropertyId: const obx_int.IdUid(11, 6421359935704911044),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 2518985729744694949),
            name: 'id',
            type: 6,
            flags: 1),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 1398625378801129663),
            name: 'episodeId',
            type: 6,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 2332564284091241545),
            name: 'podcastId',
            type: 6,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(4, 6941435227916027724),
            name: 'date',
            type: 12,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(5, 3508558160778588986),
            name: 'name',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(6, 4413032566925136018),
            name: 'imgPath',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(7, 1200095153528032150),
            name: 'episodeDuration',
            type: 8,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(8, 7720767144455971798),
            name: 'hasPodcast',
            type: 1,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(9, 2427650226394151529),
            name: 'isFavorited',
            type: 1,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(10, 3029030983731271500),
            name: 'updatedAt',
            type: 12,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(11, 6421359935704911044),
            name: 'progress',
            type: 8,
            flags: 0)
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[])
];

/// Shortcut for [obx.Store.new] that passes [getObjectBoxModel] and for Flutter
/// apps by default a [directory] using `defaultStoreDirectory()` from the
/// ObjectBox Flutter library.
///
/// Note: for desktop apps it is recommended to specify a unique [directory].
///
/// See [obx.Store.new] for an explanation of all parameters.
///
/// For Flutter apps, also calls `loadObjectBoxLibraryAndroidCompat()` from
/// the ObjectBox Flutter library to fix loading the native ObjectBox library
/// on Android 6 and older.
Future<obx.Store> openStore(
    {String? directory,
    int? maxDBSizeInKB,
    int? maxDataSizeInKB,
    int? fileMode,
    int? maxReaders,
    bool queriesCaseSensitiveDefault = true,
    String? macosApplicationGroup}) async {
  await loadObjectBoxLibraryAndroidCompat();
  return obx.Store(getObjectBoxModel(),
      directory: directory ?? (await defaultStoreDirectory()).path,
      maxDBSizeInKB: maxDBSizeInKB,
      maxDataSizeInKB: maxDataSizeInKB,
      fileMode: fileMode,
      maxReaders: maxReaders,
      queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
      macosApplicationGroup: macosApplicationGroup);
}

/// Returns the ObjectBox model definition for this project for use with
/// [obx.Store.new].
obx_int.ModelDefinition getObjectBoxModel() {
  final model = obx_int.ModelInfo(
      entities: _entities,
      lastEntityId: const obx_int.IdUid(41, 6594091496338156520),
      lastIndexId: const obx_int.IdUid(12, 2456002596466727755),
      lastRelationId: const obx_int.IdUid(10, 2249377372459245711),
      lastSequenceId: const obx_int.IdUid(0, 0),
      retiredEntityUids: const [
        7018342820532340542,
        6617065807813839953,
        733705232548633906,
        4115633510275317470,
        4381796077712529281,
        5323614882679986261,
        3848293759086337729,
        2190812714372107188,
        8026574528514444656,
        3914905301026288011,
        8129150239754424270,
        9079713600584516994,
        6217248595519736827,
        598295649207872808,
        1847342292373639521,
        1850460572925164179,
        4960475103318907402,
        2909480661795046150,
        3702104701358215069,
        686778404991606262,
        6275609622422043273,
        157674044297935199,
        8584565244885080745,
        466658860776363096,
        5110975088403602075,
        4336785561592995760,
        9111466945699906774,
        1660500475389295279,
        5152463046543528017,
        3708858297125959236,
        431433758997861258,
        154798782468374728,
        2230368436758010435,
        5549877949975868131,
        7756478160039821406,
        3444624404467286271,
        7194538433056617130
      ],
      retiredIndexUids: const [],
      retiredPropertyUids: const [
        1598863114242869578,
        281332924376562555,
        7847201808243043888,
        1066757186899219979,
        1554327976715795163,
        4802138597239927106,
        1087412274143091775,
        8652247316615162625,
        1218643663322711513,
        7994117848910663628,
        6149495895523292099,
        4377457754294731466,
        6177503316743781681,
        1971017464268503269,
        2108725360110049696,
        1247922333751369077,
        510287242465272811,
        3927273753388597922,
        8738657811984894197,
        5316146940385410851,
        9059147871563884704,
        6645249811454529906,
        5611882818224434979,
        624759002716618432,
        48120267516861344,
        4534514829423239803,
        7589482335613505015,
        885353150911281276,
        5880396553979634622,
        413435580118323601,
        6047414601147094418,
        186322524371234826,
        1910292987121979689,
        3338280944541340000,
        5103718272217501928,
        3711978540527931139,
        5263789547039501554,
        7003178591736618315,
        2754282830360476997,
        9042701442228590959,
        8560288422282421403,
        8023292685714534953,
        9146589443927443154,
        1313231648526925297,
        1988048316500443304,
        4444834438019665829,
        7692206062662167080,
        5013780114302001310,
        7036672595152586897,
        1308549214743722609,
        4135968495009192861,
        8411912475713391474,
        71219210565185711,
        3492297580501183871,
        3339056196823559045,
        288747211962632989,
        8180130415086420440,
        4400976373817325127,
        7098818677678674524,
        721454993832132390,
        4845995914481596226,
        7542967836746836155,
        5955137352764560186,
        7110440714234381570,
        4827537776549795293,
        8151517275796841915,
        1057416709728733674,
        3254905081064778115,
        4728416452624839522,
        6852963765448735474,
        1603697849129868799,
        4171455595826512963,
        7144557477369682599,
        903940804684556573,
        3694823457279950387,
        7104028307244782069,
        355748435672731201,
        38353429359960581,
        2259679366225844194,
        6130387760342169769,
        1255864708248645473,
        3191260204349440511,
        701805690188399603,
        5309749079339568730,
        1776169484091158962,
        3345392090542985279,
        7417973334998021765,
        7683314106615094904,
        5123398083403746296,
        1531101431876519931,
        2017490932517286518,
        1904812446304158006,
        1520533850589353794,
        7162624023361975606,
        879603288355287610,
        3031314473181113401,
        7394865029731165766,
        3129870044676099246,
        7233067596908147080,
        5679452394226639823,
        2272846876953946599,
        2934090052295920704,
        5039011711131039381,
        2832955969049071344,
        4382351010281716637,
        8066699207810227823,
        5042054856506858374,
        511204630468078087,
        1536166243963478250,
        3934929415554545221,
        4073053512368220135,
        915326186029784664,
        6011258683304841222,
        663083286074984295,
        3335877965820829924,
        4799382126873659590,
        5547615802441315477,
        4439471109419617729,
        7409928459813240008,
        3964423143510826197,
        1147708726181546496,
        1385420569884712666,
        1184958517239239559,
        2489786520354821335,
        6778071727569109750,
        5089020486691478610,
        1008393106709575467,
        2459819958957260207,
        658863467905878004,
        7239929551941146135,
        1832193523955873590,
        6640321004458434955,
        3368492684756941769,
        5340609205633805495,
        6098306736936310243,
        3421089361332048868,
        7792613891986561765,
        8198054036629078130,
        5416088168105154286,
        7348136757304807174,
        6640011352764925486,
        3702427829382900205,
        5119032133954733929,
        2762916143028193134,
        7448834828010321823,
        4427746636840137948,
        5885258237381127843,
        4285690815082203531,
        7262289789702358582,
        5919337261224320992,
        8244538701373217941,
        5301666506709806707,
        3095807101891828165,
        4704338535705261885,
        2054495545006527043,
        654787384023526827,
        6451172658866739028,
        3289103326228593198,
        3217041058122541106,
        8865423363343771418,
        725533992369227960,
        7345159083849049751,
        8489474658043753054,
        2005054531215622735,
        6429760581112312050,
        8256700680936669197,
        3634270379433828695,
        7961281825179721831,
        4697311684380312626,
        4598031670336787670,
        3370007404032409163,
        8506457959561259420,
        5392793506629358629,
        2060514056327211870,
        4982936592413500551,
        8916094431183428731,
        5302195662707552261,
        8047692785258331307,
        8222434574255145992,
        4675967203775853746,
        6840731254905383211,
        3848204243082041032,
        1209776839622953627,
        1654696065221484330,
        110336067330061604,
        5312776070517521524,
        3762272915121993336,
        340349468540130358,
        2691341324536417134,
        5153448247584343931,
        1920504629713085655,
        4998106812988543025,
        3878494832621386936,
        4462717650242994915,
        4531053336255931598,
        1864423220478907303,
        8445513182389506788,
        2892685351119570446,
        2353942972424050400,
        3916820256089920789,
        4627331882403689501,
        7829191532793682894,
        8536366524481126165,
        8054667228125791907,
        6386507528775349385,
        6381658644011022946,
        4176529117011795643,
        1088544046315196539,
        1314965858799691602,
        8575235814807802968,
        1889189265985135611,
        741698754910642832,
        8473980001552216579,
        7145814983387690569,
        4979531434460035130,
        1519964685129625099,
        8829854655733711273,
        1436379725794364795,
        1625185003779385204,
        527546545357366472,
        1772971478291868769,
        5772149234503330341,
        545643238643735384,
        1584158400783728133
      ],
      retiredRelationUids: const [
        559890034703527719,
        3085588869725977564,
        1106612667264191900,
        1485175582944490848,
        9167755709177125862,
        2249377372459245711
      ],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, obx_int.EntityDefinition>{
    Author: obx_int.EntityDefinition<Author>(
        model: _entities[0],
        toOneRelations: (Author object) => [],
        toManyRelations: (Author object) => {},
        getId: (Author object) => object.id,
        setId: (Author object, int id) {
          object.id = id;
        },
        objectToFB: (Author object, fb.Builder fbb) {
          final nameOffset = fbb.writeString(object.name);
          fbb.startTable(4);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, nameOffset);
          fbb.addBool(2, object.isGuest);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final idParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          final nameParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 6, '');
          final isGuestParam =
              const fb.BoolReader().vTableGet(buffer, rootOffset, 8, false);
          final object =
              Author(id: idParam, name: nameParam, isGuest: isGuestParam);

          return object;
        }),
    Podcast: obx_int.EntityDefinition<Podcast>(
        model: _entities[1],
        toOneRelations: (Podcast object) => [],
        toManyRelations: (Podcast object) => {
              obx_int.RelInfo<Podcast>.toMany(5, object.id): object.authors,
              obx_int.RelInfo<Podcast>.toMany(6, object.id): object.schedules
            },
        getId: (Podcast object) => object.id,
        setId: (Podcast object, int id) {
          object.id = id;
        },
        objectToFB: (Podcast object, fb.Builder fbb) {
          final podcastNameOffset = fbb.writeString(object.podcastName);
          final imageOffset = fbb.writeString(object.image);
          fbb.startTable(11);
          fbb.addInt64(0, object.id);
          fbb.addInt64(1, object.podcastId);
          fbb.addOffset(2, podcastNameOffset);
          fbb.addBool(3, object.onlyMusic);
          fbb.addBool(4, object.isActive);
          fbb.addBool(5, object.hasEpisodes);
          fbb.addBool(7, object.isFavorited);
          fbb.addOffset(9, imageOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final idParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          final podcastIdParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 6, 0);
          final podcastNameParam =
              const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 8, '');
          final authorsParam = obx.ToMany<Author>();
          final schedulesParam = obx.ToMany<Schedule>();
          final onlyMusicParam =
              const fb.BoolReader().vTableGet(buffer, rootOffset, 10, false);
          final isActiveParam =
              const fb.BoolReader().vTableGet(buffer, rootOffset, 12, false);
          final hasEpisodesParam =
              const fb.BoolReader().vTableGet(buffer, rootOffset, 14, false);
          final imageParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 22, '');
          final isFavoritedParam =
              const fb.BoolReader().vTableGet(buffer, rootOffset, 18, false);
          final object = Podcast(
              id: idParam,
              podcastId: podcastIdParam,
              podcastName: podcastNameParam,
              authors: authorsParam,
              schedules: schedulesParam,
              onlyMusic: onlyMusicParam,
              isActive: isActiveParam,
              hasEpisodes: hasEpisodesParam,
              image: imageParam,
              isFavorited: isFavoritedParam);
          obx_int.InternalToManyAccess.setRelInfo<Podcast>(object.authors,
              store, obx_int.RelInfo<Podcast>.toMany(5, object.id));
          obx_int.InternalToManyAccess.setRelInfo<Podcast>(object.schedules,
              store, obx_int.RelInfo<Podcast>.toMany(6, object.id));
          return object;
        }),
    Schedule: obx_int.EntityDefinition<Schedule>(
        model: _entities[2],
        toOneRelations: (Schedule object) => [],
        toManyRelations: (Schedule object) => {},
        getId: (Schedule object) => object.id,
        setId: (Schedule object, int id) {
          object.id = id;
        },
        objectToFB: (Schedule object, fb.Builder fbb) {
          final startOffset = fbb.writeString(object.start);
          final endOffset = fbb.writeString(object.end);
          fbb.startTable(5);
          fbb.addInt64(0, object.id);
          fbb.addInt64(1, object.weekday);
          fbb.addOffset(2, startOffset);
          fbb.addOffset(3, endOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final idParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          final weekdayParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 6, 0);
          final startParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 8, '');
          final endParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 10, '');
          final object = Schedule(
              id: idParam,
              weekday: weekdayParam,
              start: startParam,
              end: endParam);

          return object;
        }),
    Episode: obx_int.EntityDefinition<Episode>(
        model: _entities[3],
        toOneRelations: (Episode object) => [],
        toManyRelations: (Episode object) => {},
        getId: (Episode object) => object.id,
        setId: (Episode object, int id) {
          object.id = id;
        },
        objectToFB: (Episode object, fb.Builder fbb) {
          final nameOffset = fbb.writeString(object.name);
          final imgPathOffset = fbb.writeString(object.imgPath);
          fbb.startTable(12);
          fbb.addInt64(0, object.id);
          fbb.addInt64(1, object.episodeId);
          fbb.addInt64(2, object.podcastId);
          fbb.addInt64(3, object.date.microsecondsSinceEpoch * 1000);
          fbb.addOffset(4, nameOffset);
          fbb.addOffset(5, imgPathOffset);
          fbb.addFloat64(6, object.episodeDuration);
          fbb.addBool(7, object.hasPodcast);
          fbb.addBool(8, object.isFavorited);
          fbb.addInt64(
              9,
              object.updatedAt == null
                  ? null
                  : object.updatedAt!.microsecondsSinceEpoch * 1000);
          fbb.addFloat64(10, object.progress);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final updatedAtValue =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 22);
          final idParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          final episodeIdParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 6, 0);
          final podcastIdParam =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 8);
          final dateParam = DateTime.fromMicrosecondsSinceEpoch(
              (const fb.Int64Reader().vTableGet(buffer, rootOffset, 10, 0) /
                      1000)
                  .round());
          final nameParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 12, '');
          final imgPathParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 14, '');
          final episodeDurationParam =
              const fb.Float64Reader().vTableGet(buffer, rootOffset, 16, 0);
          final hasPodcastParam =
              const fb.BoolReader().vTableGet(buffer, rootOffset, 18, false);
          final isFavoritedParam =
              const fb.BoolReader().vTableGet(buffer, rootOffset, 20, false);
          final updatedAtParam = updatedAtValue == null
              ? null
              : DateTime.fromMicrosecondsSinceEpoch(
                  (updatedAtValue / 1000).round());
          final progressParam =
              const fb.Float64Reader().vTableGet(buffer, rootOffset, 24, 0);
          final object = Episode(
              id: idParam,
              episodeId: episodeIdParam,
              podcastId: podcastIdParam,
              date: dateParam,
              name: nameParam,
              imgPath: imgPathParam,
              episodeDuration: episodeDurationParam,
              hasPodcast: hasPodcastParam,
              isFavorited: isFavoritedParam,
              updatedAt: updatedAtParam,
              progress: progressParam);

          return object;
        })
  };

  return obx_int.ModelDefinition(model, bindings);
}

/// [Author] entity fields to define ObjectBox queries.
class Author_ {
  /// See [Author.id].
  static final id =
      obx.QueryIntegerProperty<Author>(_entities[0].properties[0]);

  /// See [Author.name].
  static final name =
      obx.QueryStringProperty<Author>(_entities[0].properties[1]);

  /// See [Author.isGuest].
  static final isGuest =
      obx.QueryBooleanProperty<Author>(_entities[0].properties[2]);
}

/// [Podcast] entity fields to define ObjectBox queries.
class Podcast_ {
  /// See [Podcast.id].
  static final id =
      obx.QueryIntegerProperty<Podcast>(_entities[1].properties[0]);

  /// See [Podcast.podcastId].
  static final podcastId =
      obx.QueryIntegerProperty<Podcast>(_entities[1].properties[1]);

  /// See [Podcast.podcastName].
  static final podcastName =
      obx.QueryStringProperty<Podcast>(_entities[1].properties[2]);

  /// See [Podcast.onlyMusic].
  static final onlyMusic =
      obx.QueryBooleanProperty<Podcast>(_entities[1].properties[3]);

  /// See [Podcast.isActive].
  static final isActive =
      obx.QueryBooleanProperty<Podcast>(_entities[1].properties[4]);

  /// See [Podcast.hasEpisodes].
  static final hasEpisodes =
      obx.QueryBooleanProperty<Podcast>(_entities[1].properties[5]);

  /// See [Podcast.isFavorited].
  static final isFavorited =
      obx.QueryBooleanProperty<Podcast>(_entities[1].properties[6]);

  /// See [Podcast.image].
  static final image =
      obx.QueryStringProperty<Podcast>(_entities[1].properties[7]);

  /// see [Podcast.authors]
  static final authors =
      obx.QueryRelationToMany<Podcast, Author>(_entities[1].relations[0]);

  /// see [Podcast.schedules]
  static final schedules =
      obx.QueryRelationToMany<Podcast, Schedule>(_entities[1].relations[1]);
}

/// [Schedule] entity fields to define ObjectBox queries.
class Schedule_ {
  /// See [Schedule.id].
  static final id =
      obx.QueryIntegerProperty<Schedule>(_entities[2].properties[0]);

  /// See [Schedule.weekday].
  static final weekday =
      obx.QueryIntegerProperty<Schedule>(_entities[2].properties[1]);

  /// See [Schedule.start].
  static final start =
      obx.QueryStringProperty<Schedule>(_entities[2].properties[2]);

  /// See [Schedule.end].
  static final end =
      obx.QueryStringProperty<Schedule>(_entities[2].properties[3]);
}

/// [Episode] entity fields to define ObjectBox queries.
class Episode_ {
  /// See [Episode.id].
  static final id =
      obx.QueryIntegerProperty<Episode>(_entities[3].properties[0]);

  /// See [Episode.episodeId].
  static final episodeId =
      obx.QueryIntegerProperty<Episode>(_entities[3].properties[1]);

  /// See [Episode.podcastId].
  static final podcastId =
      obx.QueryIntegerProperty<Episode>(_entities[3].properties[2]);

  /// See [Episode.date].
  static final date =
      obx.QueryDateNanoProperty<Episode>(_entities[3].properties[3]);

  /// See [Episode.name].
  static final name =
      obx.QueryStringProperty<Episode>(_entities[3].properties[4]);

  /// See [Episode.imgPath].
  static final imgPath =
      obx.QueryStringProperty<Episode>(_entities[3].properties[5]);

  /// See [Episode.episodeDuration].
  static final episodeDuration =
      obx.QueryDoubleProperty<Episode>(_entities[3].properties[6]);

  /// See [Episode.hasPodcast].
  static final hasPodcast =
      obx.QueryBooleanProperty<Episode>(_entities[3].properties[7]);

  /// See [Episode.isFavorited].
  static final isFavorited =
      obx.QueryBooleanProperty<Episode>(_entities[3].properties[8]);

  /// See [Episode.updatedAt].
  static final updatedAt =
      obx.QueryDateNanoProperty<Episode>(_entities[3].properties[9]);

  /// See [Episode.progress].
  static final progress =
      obx.QueryDoubleProperty<Episode>(_entities[3].properties[10]);
}
