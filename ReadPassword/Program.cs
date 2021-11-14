// Create the path from two environement variables
var directory = Environment.GetEnvironmentVariable("REPRT_SECRET");
var filename = Environment.GetEnvironmentVariable("SECRET_FILE_NAME");
if (directory == null || filename == null)
{
    Console.WriteLine("Please set the environment variables REPRT_SECRET and SECRET_FILE_NAME");
    Environment.Exit(1);
}
var path = Path.Combine(directory, filename);

// Read the password from the secret file
var secret = File.ReadAllText(path);

// Print the password
Console.Write(secret.Trim());