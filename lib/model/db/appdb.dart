// @dart=2.9

// Dart imports:
import 'dart:async';
import 'dart:io' as io;

// Package imports:
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

// Project imports:
import 'package:my_idena/model/db/account.dart';
import 'package:my_idena/model/db/contact.dart';
import 'package:my_idena/util/app_ffi/apputil.dart';

class DBHelper {
  static const int DB_VERSION = 1;
  static const String CONTACTS_SQL = """CREATE TABLE Contacts( 
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        name TEXT, 
        address TEXT)""";
  static const String ACCOUNTS_SQL = """CREATE TABLE Accounts( 
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        name TEXT, 
        acct_index INTEGER, 
        selected INTEGER, 
        last_accessed INTEGER,
        private_key TEXT,
        address TEXT,
        balance TEXT,
        stake TEXT)""";
  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "my_idena.db");
    var theDb = await openDatabase(path,
        version: DB_VERSION, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the tables
    await db.execute(CONTACTS_SQL);
    await db.execute(ACCOUNTS_SQL);
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) async {}

  // Contacts
  Future<List<Contact>> getContacts() async {
    var dbClient = await db;
    List<Map> list =
        await dbClient.rawQuery('SELECT * FROM Contacts ORDER BY name');
    List<Contact> contacts = new List();
    for (int i = 0; i < list.length; i++) {
      contacts.add(new Contact(
        id: list[i]["id"],
        name: list[i]["name"],
        address: list[i]["address"],
      ));
    }
    return contacts;
  }

  Future<List<Contact>> getContactsWithNameLike(String pattern) async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery(
        'SELECT * FROM Contacts WHERE name LIKE \'%$pattern%\' ORDER BY LOWER(name)');
    List<Contact> contacts = new List();
    for (int i = 0; i < list.length; i++) {
      contacts.add(new Contact(
        id: list[i]["id"],
        name: list[i]["name"],
        address: list[i]["address"],
      ));
    }
    return contacts;
  }

  Future<Contact> getContactWithAddress(String address) async {
    var dbClient = await db;
    List<Map> list = await dbClient
        .rawQuery('SELECT * FROM Contacts WHERE address like \'%$address\'');
    if (list.length > 0) {
      return Contact(
        id: list[0]["id"],
        name: list[0]["name"],
        address: list[0]["address"],
      );
    }
    return null;
  }

  Future<Contact> getContactWithName(String name) async {
    var dbClient = await db;
    List<Map> list = await dbClient
        .rawQuery('SELECT * FROM Contacts WHERE name = ?', [name]);
    if (list.length > 0) {
      return Contact(
        id: list[0]["id"],
        name: list[0]["name"],
        address: list[0]["address"],
      );
    }
    return null;
  }

  Future<bool> contactExistsWithName(String name) async {
    var dbClient = await db;
    int count = Sqflite.firstIntValue(await dbClient.rawQuery(
        'SELECT count(*) FROM Contacts WHERE lower(name) = ?',
        [name.toLowerCase()]));
    return count > 0;
  }

  Future<bool> contactExistsWithAddress(String address) async {
    var dbClient = await db;
    int count = Sqflite.firstIntValue(await dbClient.rawQuery(
        'SELECT count(*) FROM Contacts WHERE lower(address) like \'%$address\''));
    return count > 0;
  }

  Future<int> saveContact(Contact contact) async {
    var dbClient = await db;
    return await dbClient.rawInsert(
        'INSERT INTO Contacts (name, address) values(?, ?)',
        [contact.name, contact.address]);
  }

  Future<int> saveContacts(List<Contact> contacts) async {
    int count = 0;
    for (Contact c in contacts) {
      if (await saveContact(c) > 0) {
        count++;
      }
    }
    return count;
  }

  Future<bool> deleteContact(Contact contact) async {
    var dbClient = await db;
    return await dbClient.rawDelete(
            "DELETE FROM Contacts WHERE lower(address) like \'%${contact.address.toLowerCase()}\'") >
        0;
  }

  // Accounts
  Future<List<Account>> getAccounts() async {
    var dbClient = await db;
    List<Map> list =
        await dbClient.rawQuery('SELECT * FROM Accounts ORDER BY acct_index');
    List<Account> accounts = new List();
    for (int i = 0; i < list.length; i++) {
      accounts.add(Account(
          id: list[i]["id"],
          name: list[i]["name"],
          index: list[i]["acct_index"],
          lastAccess: list[i]["last_accessed"],
          selected: list[i]["selected"] == 1 ? true : false,
          balance: list[i]["balance"],
          stake: list[i]["stake"]));
    }
    accounts.forEach((a) async {
      a.address = await AppUtil().getAddress();
    });
    return accounts;
  }

  Future<List<Account>> getRecentlyUsedAccounts({int limit = 2}) async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery(
        'SELECT * FROM Accounts WHERE selected != 1 ORDER BY last_accessed DESC, acct_index ASC LIMIT ?',
        [limit]);
    List<Account> accounts = new List();
    for (int i = 0; i < list.length; i++) {
      accounts.add(Account(
          id: list[i]["id"],
          name: list[i]["name"],
          index: list[i]["acct_index"],
          lastAccess: list[i]["last_accessed"],
          selected: list[i]["selected"] == 1 ? true : false,
          balance: list[i]["balance"],
          stake: list[i]["stake"]));
    }
    accounts.forEach((a) async {
      a.address = await AppUtil().getAddress();
    });
    return accounts;
  }

  Future<Account> addAccount({String nameBuilder}) async {
    var dbClient = await db;
    Account account;
    await dbClient.transaction((Transaction txn) async {
      int nextIndex = 1;
      int curIndex;
      List<Map> accounts = await txn.rawQuery(
          'SELECT * from Accounts WHERE acct_index > 0 ORDER BY acct_index ASC');
      for (int i = 0; i < accounts.length; i++) {
        curIndex = accounts[i]["acct_index"];
        if (curIndex != nextIndex) {
          break;
        }
        nextIndex++;
      }
      int nextID = nextIndex + 1;
      String nextName = nameBuilder.replaceAll("%1", nextID.toString());
      account = Account(
          index: nextIndex,
          name: nextName,
          lastAccess: 0,
          balance: "0",
          stake: "0",
          selected: false,
          address: await AppUtil().getAddress());
      await txn.rawInsert(
          'INSERT INTO Accounts (name, acct_index, last_accessed, selected, address, balance, stake) values(?, ?, ?, ?, ?, ?, ?)',
          [
            account.name,
            account.index,
            account.lastAccess,
            account.selected ? 1 : 0,
            account.address,
            account.balance,
            account.stake
          ]);
    });
    return account;
  }

  Future<int> deleteAccount(Account account) async {
    var dbClient = await db;
    return await dbClient.rawDelete(
        'DELETE FROM Accounts WHERE acct_index = ?', [account.index]);
  }

  Future<int> saveAccount(Account account) async {
    var dbClient = await db;
    return await dbClient.rawInsert(
        'INSERT INTO Accounts (name, acct_index, last_accessed, selected, balance, stake) values(?, ?, ?, ?, ?, ?)',
        [
          account.name,
          account.index,
          account.lastAccess,
          account.selected ? 1 : 0,
          account.balance,
          account.stake
        ]);
  }

  Future<int> changeAccountName(Account account, String name) async {
    var dbClient = await db;
    return await dbClient.rawUpdate(
        'UPDATE Accounts SET name = ? WHERE acct_index = ?',
        [name, account.index]);
  }

  Future<void> changeAccount(Account account) async {
    var dbClient = await db;
    return await dbClient.transaction((Transaction txn) async {
      await txn.rawUpdate('UPDATE Accounts set selected = 0');
      // Get access increment count
      List<Map> list = await txn
          .rawQuery('SELECT max(last_accessed) as last_access FROM Accounts');
      await txn.rawUpdate(
          'UPDATE Accounts set selected = ?, last_accessed = ? where acct_index = ?',
          [1, list[0]["last_access"] + 1, account.index]);
    });
  }

  Future<void> updateAccountBalance(Account account, String balance) async {
    var dbClient = await db;
    return await dbClient.rawUpdate(
        'UPDATE Accounts set balance = ? where acct_index = ?',
        [balance, account.index]);
  }

  Future<Account> getSelectedAccount() async {
    var dbClient = await db;
    List<Map> list =
        await dbClient.rawQuery('SELECT * FROM Accounts where selected = 1');
    if (list.length == 0) {
      return null;
    }
    Account account = Account(
        id: list[0]["id"],
        name: list[0]["name"],
        index: list[0]["acct_index"],
        selected: true,
        lastAccess: list[0]["last_accessed"],
        balance: list[0]["balance"],
        stake: list[0]["stake"],
        address: await AppUtil().getAddress());
    return account;
  }

  Future<Account> getMainAccount() async {
    var dbClient = await db;
    List<Map> list =
        await dbClient.rawQuery('SELECT * FROM Accounts where acct_index = 0');
    if (list.length == 0) {
      return null;
    }
    String address = await AppUtil().getAddress();

    Account account = Account(
        id: list[0]["id"],
        name: list[0]["name"],
        index: list[0]["acct_index"],
        selected: true,
        lastAccess: list[0]["last_accessed"],
        balance: list[0]["balance"],
        stake: list[0]["stake"],
        address: address);
    return account;
  }

  Future<void> dropAccounts() async {
    var dbClient = await db;
    return await dbClient.rawDelete('DELETE FROM ACCOUNTS');
  }
}
