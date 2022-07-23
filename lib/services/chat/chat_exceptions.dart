class ChatStorageException implements Exception {
  const ChatStorageException();
}

// C in CRUD
class CouldNotCreateChatMessageException extends ChatStorageException {}

// R in CRUD
class CouldNotGetChatMessageException extends ChatStorageException {}

// U in CRUD
class CouldNotUpdateChatMessageException extends ChatStorageException {}

// D in CRUD
class CouldNotDeleteChatMessageException extends ChatStorageException {}

// C in CRUD
class CouldNotCreateConversationException extends ChatStorageException {}

// R in CRUD
class CouldNotGetChatUserException extends ChatStorageException {}

// U in CRUD
class CouldNotUpdateChatUserException extends ChatStorageException {}

// D in CRUD
class CouldNotDeleteChatUserException extends ChatStorageException {}
