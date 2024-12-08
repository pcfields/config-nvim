// Enum
enum LogLevel {
  Info = "INFO",
  Warn = "WARN",
  Error = "ERROR",
}

// Interface
interface User {
  id: number;
  name: string;
  role: "admin" | "user";
  here: "single quotes";
}

// Generic function
function getProperty<T, K extends keyof T>(obj: T, key: K): T[K] {
  return obj[key];
}

// Union and Intersection types
type SuccessResponse = {
  success: true;
  data: unknown;
};

type ErrorResponse = {
  success: false;
  error: string;
};

type ApiResponse = SuccessResponse | ErrorResponse;

type DetailedUser = User & {
  email: string;
};

// Class with a static method
class Logger {
  static log(level: LogLevel, message: string): void {
    console.log(`[${level}] ${message}`);
  }
}

// Function overloading
function formatInput(input: string): string;
function formatInput(input: number): string;
function formatInput(input: string | number): string {
  return `Formatted: ${input.toString()}`;
}

// Async/Await with Promises
async function fetchData<T>(url: string): Promise<T> {
  const response = await fetch(url);
  if (!response.ok) {
    throw new Error(`Failed to fetch: ${response.status}`);
  }
  return response.json();
}

// Type guard
function isDetailedUser(user: User | DetailedUser): user is DetailedUser {
  return (user as DetailedUser).email !== undefined;
}

// Utility types
function pick<T, K extends keyof T>(obj: T, keys: K[]): Pick<T, K> {
  const result = {} as Pick<T, K>;
  keys.forEach((key) => {
    result[key] = obj[key];
  });
  return result;
}

// Main function demonstrating various features
async function processUserData(userId: number): Promise<ApiResponse> {
  try {
    Logger.log(LogLevel.Info, `Fetching user data for ID: ${userId}`);

    // Fetching and transforming data
    const user = await fetchData<User>(
      `https://api.example.com/users/${userId}`,
    );

    if (user.role === "admin") {
      Logger.log(LogLevel.Warn, "Admin access detected!");
    }

    const detailedUser: DetailedUser = {
      ...user,
      email: `${user.name}@example.com`,
    };

    if (isDetailedUser(detailedUser)) {
      Logger.log(LogLevel.Info, `User email: ${detailedUser.email}`);
    }

    const summary = pick(detailedUser, ["id", "name"]);
    Logger.log(LogLevel.Info, `User Summary: ${JSON.stringify(summary)}`);

    return { success: true, data: summary };
  } catch (error) {
    Logger.log(LogLevel.Error, `Error processing user data: ${error}`);
    return {
      success: false,
      error: error instanceof Error ? error.message : "Unknown error",
    };
  }
}

// Example usage
processUserData(1).then((response) => {
  if (response.success) {
    console.log("User processed successfully", response.data);
  } else {
    console.error("Failed to process user", response.error);
  }
});
