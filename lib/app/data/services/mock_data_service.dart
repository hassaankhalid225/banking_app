import 'dart:math';
import '../models/user_model.dart';
import '../models/account_model.dart';
import '../models/card_model.dart';
import '../models/transaction_model.dart';
import '../models/budget_model.dart';
import '../models/contact_model.dart';
import '../models/message_model.dart';

class MockDataService {
  static final Random _random = Random();

  // Mock User
  static UserModel getMockUser() {
    return UserModel(
      id: 'user_001',
      name: 'John Doe',
      email: 'john.doe@loubank.com',
      phone: '+1 234 567 8900',
      avatar: '',
      passcode: '1234',
      biometricEnabled: true,
      createdAt: DateTime.now().subtract(const Duration(days: 365)),
    );
  }

  // Mock Accounts
  static List<AccountModel> getMockAccounts() {
    return [
      AccountModel(
        id: 'acc_001',
        userId: 'user_001',
        accountNumber: '1234567890',
        accountType: 'Checking',
        balance: 15420.50,
        currency: 'USD',
        isPrimary: true,
      ),
      AccountModel(
        id: 'acc_002',
        userId: 'user_001',
        accountNumber: '0987654321',
        accountType: 'Savings',
        balance: 8750.25,
        currency: 'USD',
        isPrimary: false,
      ),
      AccountModel(
        id: 'acc_003',
        userId: 'user_001',
        accountNumber: '5555666677',
        accountType: 'Investment',
        balance: 25300.00,
        currency: 'USD',
        isPrimary: false,
      ),
    ];
  }

  // Mock Cards
  static List<CardModel> getMockCards() {
    return [
      CardModel(
        id: 'card_001',
        accountId: 'acc_001',
        cardNumber: '4532123456784952',
        cardType: 'VISA',
        cardHolderName: 'JOHN DOE',
        expiryDate: '12/26',
        cvv: '123',
        isActive: true,
        isFrozen: false,
        cardLimit: 10000.00,
      ),
      CardModel(
        id: 'card_002',
        accountId: 'acc_001',
        cardNumber: '5425233430109903',
        cardType: 'Mastercard',
        cardHolderName: 'JOHN DOE',
        expiryDate: '08/27',
        cvv: '456',
        isActive: true,
        isFrozen: false,
        cardLimit: 15000.00,
      ),
      CardModel(
        id: 'card_003',
        accountId: 'acc_002',
        cardNumber: '4916338506082832',
        cardType: 'VISA',
        cardHolderName: 'JOHN DOE',
        expiryDate: '03/25',
        cvv: '789',
        isActive: true,
        isFrozen: false,
        cardLimit: 5000.00,
      ),
      CardModel(
        id: 'card_004',
        accountId: 'acc_002',
        cardNumber: '5425233430109911',
        cardType: 'Mastercard',
        cardHolderName: 'JOHN DOE',
        expiryDate: '11/28',
        cvv: '321',
        isActive: true,
        isFrozen: true,
        cardLimit: 8000.00,
      ),
      CardModel(
        id: 'card_005',
        accountId: 'acc_003',
        cardNumber: '4532123456789876',
        cardType: 'VISA',
        cardHolderName: 'JOHN DOE',
        expiryDate: '06/26',
        cvv: '654',
        isActive: true,
        isFrozen: false,
        cardLimit: 20000.00,
      ),
      CardModel(
        id: 'card_006',
        accountId: 'acc_003',
        cardNumber: '5425233430109922',
        cardType: 'Mastercard',
        cardHolderName: 'JOHN DOE',
        expiryDate: '09/27',
        cvv: '987',
        isActive: true,
        isFrozen: false,
        cardLimit: 25000.00,
      ),
    ];
  }

  // Transaction categories and merchants
  static const List<String> _categories = [
    'Transfer',
    'Health',
    'Shopping',
    'Food & Dining',
    'Transportation',
    'Entertainment',
    'Bills & Utilities',
    'Groceries',
    'Travel',
    'Education',
  ];

  static const Map<String, List<String>> _merchantsByCategory = {
    'Transfer': ['John Smith', 'Sarah Johnson', 'Mike Wilson', 'Emily Davis'],
    'Health': ['City Hospital', 'HealthCare Plus', 'MediClinic', 'Pharmacy Express'],
    'Shopping': ['Amazon', 'Target', 'Walmart', 'Best Buy', 'Apple Store'],
    'Food & Dining': ['Starbucks', 'McDonald\'s', 'Pizza Hut', 'Subway', 'Chipotle'],
    'Transportation': ['Uber', 'Lyft', 'Gas Station', 'Metro Card', 'Parking'],
    'Entertainment': ['Netflix', 'Spotify', 'Cinema', 'Game Store', 'Concert Tickets'],
    'Bills & Utilities': ['Electric Company', 'Water Bill', 'Internet Provider', 'Phone Bill'],
    'Groceries': ['Whole Foods', 'Trader Joe\'s', 'Safeway', 'Costco'],
    'Travel': ['Airbnb', 'Booking.com', 'Delta Airlines', 'Hilton Hotel'],
    'Education': ['University Tuition', 'Online Course', 'Book Store', 'Library Fee'],
  };

  // Mock Transactions
  static List<TransactionModel> getMockTransactions() {
    final List<TransactionModel> transactions = [];
    final now = DateTime.now();

    // Generate 60 transactions over the past 6 months
    for (int i = 0; i < 60; i++) {
      final category = _categories[_random.nextInt(_categories.length)];
      final merchants = _merchantsByCategory[category]!;
      final merchant = merchants[_random.nextInt(merchants.length)];
      
      final daysAgo = _random.nextInt(180); // 6 months
      final timestamp = now.subtract(Duration(
        days: daysAgo,
        hours: _random.nextInt(24),
        minutes: _random.nextInt(60),
      ));

      final isCredit = _random.nextBool() && category != 'Transfer';
      final amount = _random.nextDouble() * 500 + 10; // $10 to $510

      transactions.add(TransactionModel(
        id: 'txn_${i.toString().padLeft(3, '0')}',
        accountId: 'acc_001',
        type: isCredit ? 'credit' : 'debit',
        category: category,
        amount: double.parse(amount.toStringAsFixed(2)),
        description: merchant,
        recipientName: merchant,
        recipientAvatar: '',
        timestamp: timestamp,
        status: 'completed',
      ));
    }

    // Sort by timestamp (most recent first)
    transactions.sort((a, b) => b.timestamp.compareTo(a.timestamp));

    return transactions;
  }

  // Mock Contacts
  static List<ContactModel> getMockContacts() {
    final contacts = [
      'John Smith',
      'Sarah Johnson',
      'Mike Wilson',
      'Emily Davis',
      'David Brown',
      'Lisa Anderson',
      'James Taylor',
      'Jennifer Martinez',
      'Robert Garcia',
      'Mary Rodriguez',
      'William Lee',
      'Patricia White',
    ];

    return contacts.asMap().entries.map((entry) {
      final index = entry.key;
      final name = entry.value;
      
      return ContactModel(
        id: 'contact_${index.toString().padLeft(3, '0')}',
        name: name,
        avatar: '',
        accountNumber: '${1000000000 + _random.nextInt(9000000000)}',
        isFavorite: index < 4,
        lastTransaction: index < 8 
            ? DateTime.now().subtract(Duration(days: _random.nextInt(30)))
            : null,
      );
    }).toList();
  }

  // Mock Budgets
  static List<BudgetModel> getMockBudgets() {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    final endOfMonth = DateTime(now.year, now.month + 1, 0);

    final budgetCategories = [
      {'category': 'Shopping', 'budget': 1000.0, 'spent': 750.0},
      {'category': 'Food & Dining', 'budget': 800.0, 'spent': 620.0},
      {'category': 'Transportation', 'budget': 400.0, 'spent': 380.0},
      {'category': 'Entertainment', 'budget': 300.0, 'spent': 150.0},
      {'category': 'Health', 'budget': 500.0, 'spent': 420.0},
      {'category': 'Bills & Utilities', 'budget': 600.0, 'spent': 580.0},
    ];

    return budgetCategories.asMap().entries.map((entry) {
      final index = entry.key;
      final data = entry.value;
      
      return BudgetModel(
        id: 'budget_${index.toString().padLeft(3, '0')}',
        userId: 'user_001',
        category: data['category'] as String,
        budgetAmount: data['budget'] as double,
        spentAmount: data['spent'] as double,
        period: 'monthly',
        startDate: startOfMonth,
        endDate: endOfMonth,
      );
    }).toList();
  }

  // Mock Messages
  static List<MessageModel> getMockMessages() {
    final messages = <MessageModel>[];
    final now = DateTime.now();

    // Conversation with John Smith
    messages.addAll([
      MessageModel(
        id: 'msg_001',
        conversationId: 'conv_001',
        senderId: 'user_001',
        receiverId: 'contact_000',
        message: 'Hey, can you send me the money for dinner?',
        timestamp: now.subtract(const Duration(hours: 2)),
        isRead: true,
        messageType: 'text',
      ),
      MessageModel(
        id: 'msg_002',
        conversationId: 'conv_001',
        senderId: 'contact_000',
        receiverId: 'user_001',
        message: 'Sure! Sending it now.',
        timestamp: now.subtract(const Duration(hours: 1, minutes: 55)),
        isRead: true,
        messageType: 'text',
      ),
      MessageModel(
        id: 'msg_003',
        conversationId: 'conv_001',
        senderId: 'contact_000',
        receiverId: 'user_001',
        message: 'Sent \$230',
        amount: 230.0,
        timestamp: now.subtract(const Duration(hours: 1, minutes: 50)),
        isRead: true,
        messageType: 'transfer',
      ),
      MessageModel(
        id: 'msg_004',
        conversationId: 'conv_001',
        senderId: 'user_001',
        receiverId: 'contact_000',
        message: 'Thanks! Got it.',
        timestamp: now.subtract(const Duration(hours: 1, minutes: 45)),
        isRead: true,
        messageType: 'text',
      ),
    ]);

    // Conversation with Sarah Johnson
    messages.addAll([
      MessageModel(
        id: 'msg_005',
        conversationId: 'conv_002',
        senderId: 'contact_001',
        receiverId: 'user_001',
        message: 'Payment for the concert tickets',
        timestamp: now.subtract(const Duration(days: 1)),
        isRead: true,
        messageType: 'text',
      ),
      MessageModel(
        id: 'msg_006',
        conversationId: 'conv_002',
        senderId: 'contact_001',
        receiverId: 'user_001',
        message: 'Sent \$310',
        amount: 310.0,
        timestamp: now.subtract(const Duration(days: 1, hours: -1)),
        isRead: true,
        messageType: 'transfer',
      ),
    ]);

    return messages;
  }

  // Get all mock data
  static Map<String, dynamic> getAllMockData() {
    return {
      'user': getMockUser(),
      'accounts': getMockAccounts(),
      'cards': getMockCards(),
      'transactions': getMockTransactions(),
      'contacts': getMockContacts(),
      'budgets': getMockBudgets(),
      'messages': getMockMessages(),
    };
  }
}
