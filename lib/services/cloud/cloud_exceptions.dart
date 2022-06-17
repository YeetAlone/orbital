class CloudStorageException implements Exception {
  const CloudStorageException();
}

// C in CRUD
class CouldNotCreateAppUserException extends CloudStorageException {}

// R in CRUD
class CouldNotGetAppUserException extends CloudStorageException {}

// U in CRUD
class CouldNotUpdateAppUserException extends CloudStorageException {}

// D in CRUD
class CouldNotDeleteAppUserException extends CloudStorageException {}
