# Category.delete_all
# Category.reset_pk_sequence
# Category.create(
#     [
#         {
#             category_name: 'Выключатели нагрузки',
#             friendly_url: 'vyklyuchateli_nagruzki',
#             parent_id: 0,
#             view_main: true,
#         },
#         {
#             category_name: 'Выключатель нагрузки ВНР',
#             friendly_url: 'vyklyuchatel_nagruzki_vnr',
#             parent_id: 1,
#             view_main: false,
#         },
#         {
#             category_name: 'Выключатель нагрузки ВНП',
#             friendly_url: 'vyklyuchatel_nagruzki_vnp',
#             parent_id: 1,
#             view_main: false,
#         },
#         {
#             category_name: 'Выключатель нагрузки ВНА',
#             friendly_url: 'vyklyuchatel_nagruzki_vna',
#             parent_id: 1,
#             view_main: false,
#         },
#         {
#             category_name: 'Высоковольтные предохранители',
#             friendly_url: 'vysokovoltnye_predohraniteli',
#             parent_id: 0,
#             view_main: true,
#         },
#         {
#             category_name: 'Патроны ПЭ',
#             friendly_url: 'patrony_peh',
#             parent_id: 5,
#             view_main: false,
#         },
#         {
#             category_name: 'Патроны ПЭН',
#             friendly_url: 'patrony_pehn',
#             parent_id: 5,
#             view_main: false,
#         },
#         {
#             category_name: 'Патроны ПН',
#             friendly_url: 'patrony_pn',
#             parent_id: 5,
#             view_main: false,
#         },
#         {
#             category_name: 'Патроны ПЖ',
#             friendly_url: 'patrony_pj',
#             parent_id: 5,
#             view_main: false,
#         },
#         {
#             category_name: 'Предохранители ПКТ',
#             friendly_url: 'predohraniteli_pkt',
#             parent_id: 5,
#             view_main: false,
#         },
#         {
#             category_name: 'Предохранители ПКЭ',
#             friendly_url: 'predohraniteli_pkhe',
#             parent_id: 5,
#             view_main: false,
#         },
#         {
#             category_name: 'Предохранители ПКН',
#             friendly_url: 'predohraniteli_pkn',
#             parent_id: 5,
#             view_main: false,
#         },
#         {
#             category_name: 'Предохранители ПКЭН',
#             friendly_url: 'predohraniteli_pkhen',
#             parent_id: 5,
#             view_main: false,
#         },
#         {
#             category_name: 'Предохранители ПКЖ',
#             friendly_url: 'predohraniteli_pkj',
#             parent_id: 5,
#             view_main: false,
#         },
#         {
#             category_name: 'Патроны ПТ',
#             friendly_url: 'patrony_pt',
#             parent_id: 5,
#             view_main: false,
#         },
#         {
#             category_name: 'Ограничители перенапряжения',
#             friendly_url: 'ogranichiteli_perenapryazheniya',
#             parent_id: 0,
#             view_main: true,
#         },
#         {
#             category_name: 'Разрядники',
#             friendly_url: 'razryadniki',
#             parent_id: 0,
#             view_main: true,
#         },
#         {
#             category_name: 'Разрядники РДИП, РМК, РДИМ, РДИШ',
#             friendly_url: 'razryadniki_rdip_rmk_rdim_rdish',
#             parent_id: 17,
#             view_main: false,
#         },
#         {
#             category_name: 'Разрядники РВС',
#             friendly_url: 'razryadniki_rvs',
#             parent_id: 17,
#             view_main: false,
#         },
#         {
#             category_name: 'Разрядники РВН',
#             friendly_url: 'razryadniki_rvn',
#             parent_id: 17,
#             view_main: false,
#         },
#         {
#             category_name: 'Разрядники РВО',
#             friendly_url: 'razryadniki_rvo',
#             parent_id: 17,
#             view_main: false,
#         },
#         {
#             category_name: 'Разъединители напряжения',
#             friendly_url: 'razediniteli_napryazheniya',
#             parent_id: 0,
#             view_main: true,
#         },
#         {
#             category_name: 'Разъединитель РВФЗ, РВФ',
#             friendly_url: 'razedinitel_rvfz_rvf',
#             parent_id: 22,
#             view_main: false,
#         },
#         {
#             category_name: 'Разъединитель РВР, РВРЗ',
#             friendly_url: 'razedinitel_rvr_rvrz',
#             parent_id: 22,
#             view_main: false,
#         },
#         {
#             category_name: 'Разъединитель РДЗ',
#             friendly_url: 'razedinitel_rdz',
#             parent_id: 22,
#             view_main: false,
#         },
#         {
#             category_name: 'Разъединитель РВО',
#             friendly_url: 'razedinitel_rvo',
#             parent_id: 22,
#             view_main: false,
#         },
#         {
#             category_name: 'Разъединитель РЛК, РЛКВ',
#             friendly_url: 'razedinitel_rlk_rlkv',
#             parent_id: 22,
#             view_main: false,
#         },
#         {
#             category_name: 'Разъединитель РВЗ, РВ',
#             friendly_url: 'razedinitel_rvz_rv',
#             parent_id: 22,
#             view_main: false,
#         },
#         {
#             category_name: 'Разъединитель РЛНД',
#             friendly_url: 'razedinitel_rlnd',
#             parent_id: 22,
#             view_main: false,
#         },
#         {
#             category_name: 'Изоляторы',
#             friendly_url: 'izolyatory',
#             parent_id: 0,
#             view_main: true,
#         },
#         {
#             category_name: 'Опорные линейные изоляторы',
#             friendly_url: 'opornye_linejnye_izolyatory',
#             parent_id: 30,
#             view_main: false,
#         },
#         {
#             category_name: 'Подвесные стеклянные изоляторы',
#             friendly_url: 'podvesnye_steklyannye_izolyatory',
#             parent_id: 30,
#             view_main: false,
#         },
#         {
#             category_name: 'Полимерные подвесные изоляторы',
#             friendly_url: 'polimernye_podvesnye_izolyatory',
#             parent_id: 30,
#             view_main: false,
#         },
#         {
#             category_name: 'Штыревые изоляторы',
#             friendly_url: 'shtyrevye_izolyatory',
#             parent_id: 30,
#             view_main: false,
#         },
#         {
#             category_name: 'Грозозащитный трос',
#             friendly_url: 'grozozashchitnyj_tros',
#             parent_id: 0,
#             view_main: true,
#         }
#     ]
# )
# Card.delete_all
# Card.reset_pk_sequence
# Card.create(
#     [
#         {
#             card_name: 'Опора контактной сети'
#         },
#         {
#             card_name: 'Ригели жестких поперечин'
#         },
#         {
#             card_name: 'Порталы ОРУ'
#         },
#         {
#             card_name: 'Дорожное ограждение'
#         },
#         {
#             card_name: 'Труба ЛМГ'
#         },
#         {
#             card_name: 'Стойки СКМ'
#         },
#         {
#             card_name: 'Рамная опора'
#         },
#         {
#             card_name: 'Металлические опоры ВЛ'
#         }
#
#     ]
# )
#
# Card_With_Attribute.delete_all
# Card_With_Attribute.reset_pk_sequence
# Card_With_Attribute.create(
#     [
#         {
#             card_id: 1,
#             product_atrs_id: 1
#         },
#         {
#             card_id: 2,
#             product_atrs_id: 1
#         },
#         {
#             card_id: 3,
#             product_atrs_id: 1
#         },
#         {
#             card_id: 4,
#             product_atrs_id: 1
#         },
#         {
#             card_id: 1,
#             product_atrs_id: 2
#         },
#     ]
# )
# Productatr.delete_all
# Productatr.reset_pk_sequence
# Productatr.create(
#     [
#         {
#             attribute_name: 'documentation',
#             attribute_rus_name: 'Рабочая документация'
#         },
#         {
#             attribute_name: 'technological_purpose',
#             attribute_rus_name: 'Технологическое назначение'
#         },
#         {
#             attribute_name: 'denomination',
#             attribute_rus_name: 'Наименование'
#         },
#         {
#             attribute_name: 'length',
#             attribute_rus_name: 'Длина'
#         },
#         {
#             attribute_name: 'beam_length',
#             attribute_rus_name: 'Длина балки'
#         },
#         {
#             attribute_name: 'section_length',
#             attribute_rus_name: 'Длина секции'
#         },
#         {
#             attribute_name: 'height',
#             attribute_rus_name: 'Высота'
#         },
#         {
#             attribute_name: 'height_traverse',
#             attribute_rus_name: 'Высота до траверсы'
#         },
#         {
#             attribute_name: 'retention_capacity',
#             attribute_rus_name: 'Удерживающая способность'
#         },
#         {
#             attribute_name: 'cut',
#             attribute_rus_name: 'Сечение'
#         },
#         {
#             attribute_name: 'diameter',
#             attribute_rus_name: 'Диаметр'
#         },
#         {
#             attribute_name: 'metal_thickness',
#             attribute_rus_name: 'Толщина металла'
#         },
#         {
#             attribute_name: 'corrugation_size',
#             attribute_rus_name: 'Размер гофра'
#         },
#         {
#             attribute_name: 'steel',
#             attribute_rus_name: 'Сталь'
#         },
#         {
#             attribute_name: 'weight',
#             attribute_rus_name: 'Вес'
#         },
#         {
#             attribute_name: 'number_blocks',
#             attribute_rus_name: 'Количество блоков'
#         },
#         {
#             attribute_name: 'number_elements',
#             attribute_rus_name: 'Количество элементов'
#         },
#         {
#             attribute_name: 'number_counters',
#             attribute_rus_name: 'Число стоек'
#         },
#         {
#             attribute_name: 'step_counters',
#             attribute_rus_name: 'Шаг стоек'
#         },
#         {
#             attribute_name: 'type_coating',
#             attribute_rus_name: 'Тип покрытия'
#         },
#         {
#             attribute_name: 'type_counters',
#             attribute_rus_name: 'Тип стойки'
#         },
#         {
#             attribute_name: 'type_bolts',
#             attribute_rus_name: 'Тип ригеля'
#         },
#         {
#             attribute_name: 'channel_gauge',
#             attribute_rus_name: 'Сортамент швеллера'
#         },
#         {
#             attribute_name: 'manufacturer',
#             attribute_rus_name: 'Производитель'
#         },
#         {
#             attribute_name: 'type_bearing',
#             attribute_rus_name: 'Тип опоры'
#         },
#         {
#             attribute_name: 'cradle',
#             attribute_rus_name: 'Шифр опоры'
#         },
#         {
#             attribute_name: 'clinging',
#             attribute_rus_name: 'Цепность'
#         },
#         {
#             attribute_name: 'brand_wires',
#             attribute_rus_name: 'Марка проводов'
#         },
#         {
#             attribute_name: 'сable_brand',
#             attribute_rus_name: 'Марка троса'
#         },
#         {
#             attribute_name: 'mass_with',
#             attribute_rus_name: 'Масса с покрытием'
#         },
#         {
#             attribute_name: 'mass_without',
#             attribute_rus_name: 'Масса без покрытия'
#         },
#         {
#             attribute_name: 'price',
#             attribute_rus_name: 'Цена'
#         }
#     ]
# )
# Order_Status.delete_all
# Order_Status.reset_pk_sequence
# Order_Status.create(
#     [
#         {
#             status_name: 'оформляется',
#         },
#         {
#             status_name: 'подтвержден',
#         },
#         {
#             status_name: 'доставляется',
#         },
#         {
#             status_name: 'выполнен',
#         },
#         {
#             status_name: 'отменен',
#         },
#     ]
# )
# Status_User.delete_all
# Status_User.reset_pk_sequence
# Status_User.create(
#     [
#         {
#             user_status_name: 'зарегистрирован',
#         },
#         {
#             user_status_name: 'не зарегистрирован',
#         },
#     ]
# )