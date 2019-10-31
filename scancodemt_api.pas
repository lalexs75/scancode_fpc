{ interface library for FPC and Lazarus
  Copyright (C) 2019 Lagunov Aleksey alexs75@yandex.ru

  Генерация xml файлов в формате обеман данными для СКАНКОД.Мобильный Терминал (SCANCODE.MobileTerminal)

  Структуры данных базируются на основании:

  /// \file MobileTerminalAPI.h
  /// \version 1.0.0
  /// \brief API для работы с ПП Сканкод.МобильныйТерминал


  This library is free software; you can redistribute it and/or modify it
  under the terms of the GNU Library General Public License as published by
  the Free Software Foundation; either version 2 of the License, or (at your
  option) any later version with the following modification:

  As a special exception, the copyright holders of this library give you
  permission to link this library with independent modules to produce an
  executable, regardless of the license terms of these independent modules,and
  to copy and distribute the resulting executable under terms of your choice,
  provided that you also meet, for each linked independent module, the terms
  and conditions of the license of that module. An independent module is a
  module which is not derived from or based on this library. If you modify
  this library, you may extend this exception to your version of the library,
  but you are not obligated to do so. If you do not wish to do so, delete this
  exception statement from your version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
  FITNESS FOR A PARTICULAR PURPOSE. See the GNU Library General Public License
  for more details.

  You should have received a copy of the GNU Library General Public License
  along with this library; if not, write to the Free Software Foundation,
  Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
}

unit ScancodeMT_API;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
(*
  typedef long (*MT_RequestCallback)(const char *, const char *);
  typedef long (*MT_RequestCallbackW)(const wchar_t *, const wchar_t *);
*)
  ///
  /// \brief Получить версию библиотеки
  /// \param major - указатель на мажорную версию
  /// \param minor - указатель на минорную версию
  /// \param patch - указатель на патч версию
  /// \param build - указатель на номер сборки
  ///
  //void MT_EXPORT MT_GetVersion(long *major, long *minor, long *patch, long *build);
  TMT_GetVersion = procedure(var Major:LongInt; var Minor:LongInt; var Patch:LongInt; var Build:LongInt);

  ///
  /// \brief Получить версию протокола
  /// \param version - версия протокола между устройством и обработчиком
  /// (сообщается устройству)
  /// \return версия протокола между обработчиком и библиотекой
  ///
  //long MT_EXPORT MT_GetProtocolVersion(long version);
  TMT_GetProtocolVersion = function(Version:LongInt):LongInt;

  ///
  /// \brief Получить код последней ошибки и ее описание
  /// \param description - указатель на строковоую переменную, в которую
  /// будет записано описание
  /// \return код ошибки
  /// \note Можно передать NULL, если описание не требуется
  /// \note ANSI версия
  ///
  //long MT_EXPORT MT_GetLastError(char *description);
  TMT_GetLastError = function(Description:PChar):LongInt;
(*
  ///
  /// \brief Получить код последней ошибки и ее описание
  /// \param description - указатель на строковоую переменную, в которую
  /// будет записано описание
  /// \return код ошибки
  /// \note Можно передать NULL, если описание не требуется
  /// \note Unicode версия
  ///
  long MT_EXPORT MT_GetLastErrorW(wchar_t *description);

  ///
  /// \brief Установить путь поиска обновлений приложения для устройства
  /// \param path - полный путь к каталогу обновлений
  /// \note ANSI версия
  ///
  void MT_EXPORT MT_SetUpdatePath(const char *path);

  ///
  /// \brief Установить путь поиска обновлений приложения для устройства
  /// \param path - полный путь к каталогу обновлений
  /// \note Unicode версия
  ///
  void MT_EXPORT MT_SetUpdatePathW(const wchar_t *path);

  ///
  /// \brief Установить функцию обратного вызова для запросов от устройства
  /// \param callbackFunc - указатель на функцию
  /// \note ANSI версия
  ///
  void MT_EXPORT MT_SetRequestCallback(MT_RequestCallback callbackFunc);

  ///
  /// \brief Установить функцию обратного вызова для запросов от устройства
  /// \param callbackFunc - указатель на функцию
  /// \note Unicode версия
  ///
  void MT_EXPORT MT_SetRequestCallbackW(MT_RequestCallbackW callbackFunc);

  ///
  /// \brief Запустить tcp сервер
  /// \param port - порт для прослушивания
  /// \return 1 - запушен, 0 - ошибка
  ///
  long MT_EXPORT MT_StartServer(long port);

  ///
  /// \brief Запустить tcp сервер с портом по умолчанию (3004)
  /// \return 1 - запушен, 0 - ошибка
  ///
  long MT_EXPORT MT_StartServerDefault();

  ///
  /// \brief Остановить tcp сервер
  /// \return 1 - остановлен, 0 - ошибка
  ///
  long MT_EXPORT MT_StopServer();

  ///
  /// \brief Ответ для устройства
  /// \param command - Имя команды на которую ответили
  /// \param data - XML с информацией
  /// \note ANSI версия
  ///
  void MT_EXPORT MT_SendAnswer(const char *command, const char *data);

  ///
  /// \brief Ответ для устройства
  /// \param command - Имя команды на которую ответили
  /// \param data - XML с информацией
  /// \note Unicode версия
  ///
  void MT_EXPORT MT_SendAnswerW(const wchar_t *command, const wchar_t *data);
*)
implementation

end.

